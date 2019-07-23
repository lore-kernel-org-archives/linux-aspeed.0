From: Vijay Khemka <vijaykhemka@fb.com>
Date: Tue, 23 Jul 2019 00:12:13 +0000
Subject: [PATCH] dt-bindings: hwmon: Add binding for pxe1610
In-Reply-To: <20190722200622.GA20435@roeck-us.net>
References: <20190722192451.1947348-1-vijaykhemka@fb.com>
 <20190722192451.1947348-2-vijaykhemka@fb.com>
 <20190722200622.GA20435@roeck-us.net>
Message-ID: <6E2B35D8-B538-4C96-B289-27A87ECD74DB@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 7/22/19, 1:06 PM, "Guenter Roeck" <groeck7 at gmail.com on behalf of linux@roeck-us.net> wrote:

    On Mon, Jul 22, 2019 at 12:24:48PM -0700, Vijay Khemka wrote:
    > Added new DT binding document for Infineon PXE1610 devices.
    > 
    > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    > ---
    >  .../devicetree/bindings/hwmon/pxe1610.txt         | 15 +++++++++++++++
    >  1 file changed, 15 insertions(+)
    >  create mode 100644 Documentation/devicetree/bindings/hwmon/pxe1610.txt
    > 
    > diff --git a/Documentation/devicetree/bindings/hwmon/pxe1610.txt b/Documentation/devicetree/bindings/hwmon/pxe1610.txt
    > new file mode 100644
    > index 000000000000..635daf4955db
    > --- /dev/null
    > +++ b/Documentation/devicetree/bindings/hwmon/pxe1610.txt
    > @@ -0,0 +1,15 @@
    > +pxe1610 properties
    > +
    > +Required properties:
    > +- compatible: Must be one of the following:
    > +	- "infineon,pxe1610" for pxe1610
    > +	- "infineon,pxe1110" for pxe1610
    > +	- "infineon,pxm1310" for pxm1310
    > +- reg: I2C address
    > +
    > +Example:
    > +
    > +vr at 48 {
    > +	compatible = "infineon,pxe1610";
    > +	reg = <0x48>;
    > +};
    
    Wouldn't it be better to add this to
    ./Documentation/devicetree/bindings/trivial-devices.txt ?
Sure, I didn't know about this file. I will add and send another patch. It is 
Documentation/devicetree/bindings/trivial-devices.yaml. How do I abandon 
this patch or just leave it.
    
    Thanks,
    Guenter
    

