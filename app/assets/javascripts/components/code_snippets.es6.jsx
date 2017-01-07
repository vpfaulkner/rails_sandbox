class CodeSnippets extends React.Component {
  render() {
    return (
      <div className="thirteen wide column">
        <div className="ui top attached tabular menu tab-menu">
          <a className="active item code-tab" data-tab="controller">Controller</a>
          <a className="item code-tab" data-tab="model">Model</a>
          <a className="item code-tab" data-tab="views">Views</a>
          <a className="item code-tab" data-tab="routes">Routes</a>
        </div>
        <div className="ui bottom attached tab segment active" data-tab="controller">
          <div id="controller" className="ui grid"></div>
        </div>
        <div className="ui bottom attached tab segment" data-tab="model">
          <div id="model" className="ui grid"></div>
        </div>
        <div className="ui bottom attached tab segment" data-tab="views">
          <div id="views" className="ui grid"></div>
        </div>
        <div className="ui bottom attached tab segment" data-tab="routes">
          <div id="routes" className="ui grid"></div>
        </div>
      </div>
    );
  }
};
