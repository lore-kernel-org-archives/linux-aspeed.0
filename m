From: Rob Herring <robh@kernel.org>
Date: Wed, 4 Mar 2020 10:16:10 -0600
Subject: [PATCH v7 7/7] dt-bindings: usb: add documentation for aspeed
 usb-vhub
In-Reply-To: <20200303062336.7361-8-rentao.bupt@gmail.com>
References: <20200303062336.7361-1-rentao.bupt@gmail.com>
 <20200303062336.7361-8-rentao.bupt@gmail.com>
Message-ID: <20200304161610.GA26873@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon,  2 Mar 2020 22:23:36 -0800, rentao.bupt at gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Add device tree binding documentation for the Aspeed USB 2.0 Virtual HUb
> Controller.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
>  Changes in v7:
>    - updated to dual license.
>    - removed description for "reg" and "clocks" properties.
>    - Added constraints (minimum/maximum/default) for vendor specific
>      properties.
>  Changes in v6:
>    - added 2 required properties into example and passed "make
>      dt_binding_check".
>  Changes in v5:
>    - updated maintainer to Ben.
>    - refined patch description per Joel's suggestion.
>  No change in v2/v3/v4:
>    - the patch is added to the patch series since v4.
> 
>  .../bindings/usb/aspeed,usb-vhub.yaml         | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
