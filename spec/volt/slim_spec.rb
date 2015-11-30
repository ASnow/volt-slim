require 'spec_helper'

describe Volt::Slim do
  it 'has a version number' do
    expect(Volt::Slim::VERSION).not_to be nil
  end

  it 'convert templates' do
    html = Volt::Slim::Compiler.build(<<SLIM)
tpl-template
  | Body
SLIM
    expect(html).to eq(<<SBR)
<:Template>
Body
SBR
  end

  it 'convert template use' do
    html = Volt::Slim::Compiler.build(<<SLIM)
use-template
  | Body
SLIM
    expect(html).to eq(<<SBR.gsub(/\n\z/, ''))
<:template>
Body
</:template>
SBR
  end

  it 'convert template use with attributes' do
    html = Volt::Slim::Compiler.build(<<SLIM)
use-template attr=val
  | Body
SLIM
    expect(html).to eq(<<SBR.gsub(/\n\z/, ''))
<:template attr="{{ val }}">
Body
</:template>
SBR
  end

  it 'convert "if ... esle"' do
    html = Volt::Slim::Compiler.build(<<SLIM)
tpl-template
  - if true
    | true
  - else
    | false
SLIM
    expect(html).to eq(<<SBR.gsub(/\n\z/, ''))
<:Template>
{{ if true }}
true
{{ else }}
false

  {{ end }}
SBR
  end

  it 'handle white space' do
    html = Volt::Slim::Compiler.build(<<SLIM)
.wrap
  .before-space=< var
.wrap
  .after-space=> var
.wrap
  .wrap-space=<> var
.wrap
  .interpolation \#{ var }
.wrap
  | text
.wrap
  | \#{ var }
SLIM

    expect(html).to eq(<<SBR.gsub(/\n\z/, ''))
<div class="wrap">
 <div class="before-space">{{ var }}</div></div><div class="wrap">
<div class="after-space">{{ var }}</div> </div><div class="wrap">
 <div class="wrap-space">{{ var }}</div> </div><div class="wrap">
<div class="interpolation">{{  var  }}</div>
</div><div class="wrap">
text
</div><div class="wrap">
{{  var  }}
</div>
SBR

  end
end

