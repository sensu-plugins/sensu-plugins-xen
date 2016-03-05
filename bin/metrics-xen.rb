#! /usr/bin/env ruby
#
#   metrics-xen.rb
#
# DESCRIPTION:
#   This plugin collects metrics from xentop
#
# OUTPUT:
#   metric data
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#   metrics-xen.rb
#
# NOTES:
#
#
# LICENSE:
#   Copyright Marc-Andre Gatien <m.gatien@gmail.com>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#
require 'sensu-plugin/metric/cli'
require 'socket'

class XenGraphite < Sensu::Plugin::Metric::CLI::Graphite
  option :scheme,
         description: 'Metric naming scheme, text to prepend to metric',
         short: '-s SCHEME',
         long: '--scheme SCHEME',
         default: '#{Socket.gethostbyname("#{Socket.gethostname}").first}.xen'

  def run
    xen = metrics_hash
    xm = xm_hash
    xencount = xenservers
    i = 0
    xen.each do |_k, v|
      result = v.split(' ')
      metrics = {
        :"#{xencount[i]}" => {
          CPUs: result[0],
          CPUp: result[1],
          MEMk: result[2],
          MEMp: result[3],
          MAXMEMk: result[4].to_i,
          MAXMEMp: result[5].to_f,
          VCPUs: result[6].to_i,
          NETS: result[7],
          NETTX: result[8],
          NETRX: result[9],
          VBDS: result[10],
          VBD_OO: result[11],
          VBD_RD: result[12],
          VBD_WR: result[13],
          VBD_RSECT: result[14],
          VBD_WSECT: result[15],
          SSID: result[16]
        }
      }
      i += 1
      metrics.each do |parent, children|
        children.each do |child, value|
          output [config[:scheme], parent, child].join('.'), value
        end
      end
    end
    xm.each do |k, v|
      output [config[:scheme], 'Domain-0', k].join('.'), v
    end
    ok
  end

  def xenservers
    xencount = []
    xentop_output.each_line do |line|
      xencount.push(line.split.first(1).join(' ').split('.').first)
    end
    xencount.uniq
  end

  def metrics_hash
    xen = {}
    xencount = xenservers
    c = xencount.count - 1
    xentop_output.each_line.with_index do |line, lineno|
      next if lineno <= c
      xen[line.split.first(1).join(' ')] = line.split.drop(2).join(' ')
    end
    xen
  end

  def xm_hash
    xen_info = {}
    `sudo xm info`.each_line do |line|
      if /(nr_cpus|cores_per_socket|threads_per_core|total_memory|free_memory|free_cpus|nr_nodes)/ =~ line
        xen_info.store((line.split(' ')[0]), line.split.drop(2).join(' ').to_i)
      end
    end
    xen_info
  end

  def xentop_output
    `sudo xentop -bfi2 | grep -v NAME`
  end
end
