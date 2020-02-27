From: Tao Ren <rentao.bupt@gmail.com>
Date: Thu, 27 Feb 2020 14:42:51 -0800
Subject: [PATCH v4 7/7] dt-bindings: usb: add documentation for aspeed
 usb-vhub
In-Reply-To: <20200227165504.GA26955@bogus>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
 <20200226230346.672-8-rentao.bupt@gmail.com>
 <20200227165504.GA26955@bogus>
Message-ID: <20200227224250.GC29420@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

On Thu, Feb 27, 2020 at 10:55:04AM -0600, Rob Herring wrote:
> On Wed, 26 Feb 2020 15:03:46 -0800, rentao.bupt at gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Add device tree binding documentation for aspeed usb-vhub driver.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> >  No change in v2/v3/v4:
> >    - the patch is added to the patch series since v4.
> > 
> >  .../bindings/usb/aspeed,usb-vhub.yaml         | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.example.dt.yaml: usb-vhub at 1e6a0000: 'aspeed,vhub-downstream-ports' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.example.dt.yaml: usb-vhub at 1e6a0000: 'aspeed,vhub-generic-endpoints' is a required property
> 
> See https://patchwork.ozlabs.org/patch/1245388
> Please check and re-submit.

I ran "make dt_binding_check" in my local environment and don't see the
failures. The 2 properties are introduced in this patch set and I add
the properties in aspeed-g4/5/6 dtsi files (patch #4, #5 and #6): am I
missing something?

Sorry I forgot to add you when including the dt-binding document to the
series v4: will add you and all dt binding maintainers in v5 soon.


Cheers,

Tao
