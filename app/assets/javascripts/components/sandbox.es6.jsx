class Sandbox extends React.Component {
  constructor() {
    super();
    this.state = {
      name: 'User',
      namespace: 'Admin',
      crud: ['create', 'read', 'update', 'delete'],
      attributes: { name: 'string', email: 'string' },
      singular: false,
      // active_tab: 'controller'
    };
    this.onResourceUpdate = this.onResourceUpdate.bind(this);
    this.onNewCode = this.onNewCode.bind(this);
  }

  onNewCode(model, controller, views, routes) {
    this.setState({
      model: model,
      controller: controller,
      views: views,
      routes: routes,
    });
    highlight_code();
  }

  onResourceUpdate(name, namespace, crud, attributes, singular) {
    App.sandbox.update({
      "input": {
        "name":       name,
        "namespace":  namespace,
        "singular":   singular,
        "crud":       crud,
        "attributes": attributes,
      },
      // "active_type": active_type
    });
    this.setState({
      name: name,
      namespace: namespace,
      crud: crud,
      attributes: attributes,
      singular: singular,
    });
  }

  componentDidMount() {
    App.sandbox = App.cable.subscriptions.create("SandboxChannel", {
      connected: function() {
      },
      update: function(data) {
        // $( "div.error.label ").remove(); // Clear labels
        this.perform('update', data);
      },
      received: function(data) {
        this.onNewCode(
          data['output']['model'],
          data['output']['controller'],
          data['output']['views'],
          data['output']['routes'],
        )
      },
      disconnected: function() {},
      onNewCode: this.onNewCode
    });
  }

  render() {
    return (
      <div className="ui stackable grid">
        <div className="header-container row">
          <PageHeader/>
        </div>
        <div className="row">
          <ResourceForm
            onResourceUpdate={this.onResourceUpdate}
            name={this.state.name}
            namespace={this.state.namespace}
            crud={this.state.crud}
            attributes={this.state.attributes}
            singular={this.state.singular}
          />
        </div>
        <div className="row">
          <CodeSnippets
            model={this.state.model}
            controller={this.state.controller}
            views={this.state.views}
            routes={this.state.routes}
          />
        </div>
      </div>
    );
  }
};
