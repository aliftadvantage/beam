/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import '../repositories/models/node.dart';
import '../repositories/models/node_type_enum.dart';
import 'group.dart';
import 'unit.dart';

abstract class NodeModel {
  final String id;
  final String title;

  const NodeModel({
    required this.id,
    required this.title,
  });

  /// Constructs nodes from the response data.
  ///
  /// Models from the response are inconvenient for a direct use in the app
  /// because they come from a golang backend which does not
  /// support inheritance, and so they use an extra layer of composition
  /// which is inconvenient in Flutter.
  static List<NodeModel> fromMaps(List json) {
    return json
        .cast<Map<String, dynamic>>()
        .map<NodeResponseModel>(NodeResponseModel.fromJson)
        .map(fromResponse)
        .toList();
  }

  static NodeModel fromResponse(NodeResponseModel node) {
    switch (node.type) {
      case NodeType.group:
        return GroupModel.fromResponse(node.group!);
      case NodeType.unit:
        return UnitModel.fromResponse(node.unit!);
    }
  }
}
