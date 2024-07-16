local g = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';
 
# dashboardを生成して、必要な属性を+結合で追加していく
local dashboard = g.dashboard.new("systemd_resolved_sample_jsonnetaaa") + g.dashboard.withUid('systemd_resolved_sample_jsonnet')
  + g.dashboard.withPanels([
    g.panel.timeSeries.new('systemd-resolved cache hit rate')
    + g.panel.timeSeries.queryOptions.withTargets([
        g.query.prometheus.new(
            'prometheus',
            'rate(systemd_resolved_cache_hits_total[$__rate_interval]) / (rate(systemd_resolved_cache_hits_total[$__rate_interval]) + rate(systemd_resolved_cache_misses_total[$__rate_interval]))',
        ) + g.query.prometheus.withInterval("60")
          + g.query.prometheus.withDatasource('prometheus')
          + g.query.prometheus.withLegendFormat("sample")
    ]) + g.panel.timeSeries.queryOptions.withDatasource('prometheus', 'adk2jn9tqqiv4e')
    + g.panel.timeSeries.standardOptions.withUnit('percentunit')
    + g.panel.timeSeries.standardOptions.withMax("1")
    + g.panel.timeSeries.panelOptions.withGridPos(17,
     24, 0, 0)
]);
# Grizzlyの作法に合わせてmetadataを付与し、specにdashboardのJSONを入れ込む
{ 
  apiVersion: 'grizzly.grafana.com/v1alpha1',
  kind: 'Dashboard',
  metadata: {
    name: "systemd_resolved_sample_jsonnet",
    folder: "general" 
  },
  spec: dashboard
} 