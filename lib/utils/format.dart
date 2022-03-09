class PluginFmt {
  static Map formatRewardsChartData(Map chartData) {
    List<List> formatChart(List chartValues) {
      List<List> values = [];

      chartValues.asMap().forEach((index, ls) {
        if (ls[0].toString().contains('0x')) {
          ls = List.of(ls).map((e) => int.parse(e.toString())).toList();
        }
        values.add(ls);
      });

      return values;
    }

    final List<String> labels = [];
    List<String>.from(chartData['rewards']['labels']).asMap().forEach((k, v) {
      if ((k - 2) % 10 == 0) {
        labels.add(v);
      } else {
        labels.add('');
      }
    });

    List rewards = formatChart(List.of(chartData['rewards']['chart']));
    List points = formatChart(List.of(chartData['points']['chart']));
    List stakes = formatChart(List.of(chartData['stakes']['chart']));
    return {
      'rewards': [rewards, labels],
      'stakes': [stakes, labels],
      'points': [points, labels],
    };
  }

  static List<List> filterCandidateList(
      List<List> ls, String filter, Map accIndexMap) {
    ls.retainWhere((i) {
      String value = filter.trim().toLowerCase();
      String accName = '';
      Map? accInfo = accIndexMap[i[0]];
      if (accInfo != null) {
        accName = accInfo['identity']['display'] ?? '';
      }
      return i[0].toLowerCase().contains(value) ||
          accName.toLowerCase().contains(value);
    });
    return ls;
  }
}
