From: Patrick Williams <patrick@stwcx.xyz>
Date: Fri, 29 May 2020 12:42:10 -0500
Subject: [PATCH v2] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
In-Reply-To: <49485085-7cc7-9e29-a719-98d1e184378b@roeck-us.net>
References: <20200529124607.GA3469@cnn>
 <49485085-7cc7-9e29-a719-98d1e184378b@roeck-us.net>
Message-ID: <20200529174210.GF17541@heinlein>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Guenter,

Thanks for the initial look at this.

One question for you below...

On Fri, May 29, 2020 at 10:30:16AM -0700, Guenter Roeck wrote:
> On 5/29/20 5:46 AM, Manikandan Elumalai wrote:
> > +		/* Enable TEMP1 by default */
> > +		config |= ADM1278_TEMP1_EN;
> > +		ret = i2c_smbus_write_byte_data(client,
> > +					ADM1275_PMON_CONFIG,
> > +					config);
> > +		if (ret < 0) {
> > +		dev_err(&client->dev,
> > +			"Failed to enable temperature config\n");
> > +		return -ENODEV;
> > +		}
> 
> This can be handled in a single operation, together with ADM1278_VOUT_EN
> below. There is no need for two separate write operations.

I don't know if you noticed here but the change ends up enabling
TEMP1_EN in all cases.  Is this acceptable?  If not, do you have any
preference on how it is selected for enablement?

> >  		/* Enable VOUT if not enabled (it is disabled by default) */
> >  		if (!(config & ADM1278_VOUT_EN)) {
> > @@ -681,9 +697,6 @@ static int adm1275_probe(struct i2c_client *client,
> >  			}
> >  		}
> >  
> > -		if (config & ADM1278_TEMP1_EN)
> > -			info->func[0] |=
> > -				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
> >  		if (config & ADM1278_VIN_EN)
> >  			info->func[0] |= PMBUS_HAVE_VIN;
> >  		break;
> > 
> 

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200529/9450a289/attachment-0001.sig>
