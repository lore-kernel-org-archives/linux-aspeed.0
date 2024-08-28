From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 28 Aug 2024 16:55:52 +0300
Subject: [PATCH v13 2/3] i2c: aspeed: support AST2600 i2c new register
 mode driver
In-Reply-To: <OS8PR06MB75416ED990B2A32F98266A1DF2952@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <ZsNT7LPZ7-szrgBJ@smile.fi.intel.com>
 <OS8PR06MB7541EE5BA5B400445FE0295EF28E2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <ZsXVU2qy0GIANFrc@smile.fi.intel.com>
 <OS8PR06MB7541945591A62B956DA28AD9F28F2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <Zsc9_UddBybdnM1Z@smile.fi.intel.com>
 <OS8PR06MB75419F3E3A222AE941DE3007F2882@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <ZsiWp5ENQ0BeBjMn@smile.fi.intel.com>
 <OS8PR06MB7541A23130F469357B7FE5F4F28B2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <ZsxbDK25mJ0sjcQy@smile.fi.intel.com>
 <OS8PR06MB75416ED990B2A32F98266A1DF2952@OS8PR06MB7541.apcprd06.prod.outlook.com>
Message-ID: <Zs8saJYtCp6bO-3k@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 28, 2024 at 02:34:43AM +0000, Ryan Chen wrote:
> > On Mon, Aug 26, 2024 at 07:50:24AM +0000, Ryan Chen wrote:
> > > > On Fri, Aug 23, 2024 at 06:23:54AM +0000, Ryan Chen wrote:
> > > > > > On Thu, Aug 22, 2024 at 02:24:26AM +0000, Ryan Chen wrote:
> > > > > > > > On Wed, Aug 21, 2024 at 06:43:01AM +0000, Ryan Chen wrote:
> > > > > > > > > > On Mon, Aug 19, 2024 at 05:28:49PM +0800, Ryan Chen wrote:

...

> > > > > > > > > > > +	if (i2c_bus->mode == BUFF_MODE) {
> > > > > > > > > > > +		i2c_bus->buf_base =
> > > > > > > > > > devm_platform_get_and_ioremap_resource(pdev, 1, &res);
> > > > > > > > > > > +		if (!IS_ERR_OR_NULL(i2c_bus->buf_base))
> > > > > > > > > > > +			i2c_bus->buf_size = resource_size(res) / 2;
> > > > > > > > > > > +		else
> > > > > > > > > > > +			i2c_bus->mode = BYTE_MODE;
> > > > > > > > > >
> > > > > > > > > > What's wrong with positive conditional? And is it even
> > > > > > > > > > possible to have NULL here?
> > > > > > > > > >
> > > > > > > > > Yes, if dtsi fill not following yaml example have reg 1,
> > > > > > > > > that will failure at buffer
> > > > > > > > mode.
> > > > > > > > > And I can swith to byte mode.
> > > > > > > > >
> > > > > > > > > reg = <0x80 0x80>, <0xc00 0x20>;
> > > > > > > >
> > > > > > > > I was asking about if (!IS_ERR_OR_NULL(...)) line:
> > > > > > > > 1) Why 'if (!foo) {} else {}' instead of 'if (foo) {} else {}'?
> > > > > > > I will update to following.
> > > > > > > 		if (IS_ERR(i2c_bus->buf_base))
> > > > > > > 			i2c_bus->mode = BYTE_MODE;
> > > > > > > 		else
> > > > > > > 			i2c_bus->buf_size = resource_size(res) / 2;
> > > > > > >
> > > > > > > > 2) Why _NULL?
> > > > > > > 	If dtsi file is claim only 1 reg offset. reg = <0x80 0x80>;
> > > > > > > that will goto byte
> > > > > > mode.
> > > > > > > 	reg = <0x80 0x80>, <0xc00 0x20>; can support buffer mode.
> > > > > > > 	due to 2nd is buffer register offset.
> > > > > >
> > > > > > I have asked why IS_ERR_OR_NULL() and not IS_ERR().
> > > > > >
> > > > > OH, I will doing by this.
> > > > > 		if (IS_ERR_OR_NULL(i2c_bus->buf_base))
> > > >
> > > > The question about _NULL remains unanswered...
> > > Sorry, I may not catch your point.
> > > So, Do you mean I should passive coding by following?
> > 
> > No. I already mentioned that in one of the previous mails.
> > Why do you use IS_ERR_OR_NULL() and not IS_ERR()?
> > 
> > You should understand your code better than me :-)
> Understood, I will change to 

OK!

> 	if (IS_ERR(i2c_bus->buf_base))
> 		i2c_bus->mode = BYTE_MODE;
> 	else
> 		i2c_bus->buf_size = resource_size(res) / 2;
> 
> > > If (i2c_bus->buf_base > 0)
> > > 	i2c_bus->buf_size = resource_size(res) / 2; else
> > >     i2c_bus->mode = BYTE_MODE;
> > >
> > > > > 			i2c_bus->mode = BYTE_MODE;
> > > > > 		else
> > > > > 			i2c_bus->buf_size = resource_size(res) / 2;

-- 
With Best Regards,
Andy Shevchenko


