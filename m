From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 5 Jun 2020 11:04:51 -0700
Subject: [PATCH v2] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
In-Reply-To: <20200605164821.GA29990@cnn>
References: <20200529124607.GA3469@cnn>
 <49485085-7cc7-9e29-a719-98d1e184378b@roeck-us.net>
 <20200605164821.GA29990@cnn>
Message-ID: <20200605180451.GA201666@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 05, 2020 at 10:18:21PM +0530, Manikandan wrote:
> On Fri, May 29, 2020 at 10:30:16AM -0700, Guenter Roeck wrote:
> > On 5/29/20 5:46 AM, Manikandan Elumalai wrote:
> > > The adm1278 temperature sysfs attribute need it for one of the openbmc platform . 
> > > This functionality is not enabled by default, so PMON_CONFIG needs to be modified in order to enable it.
> > > 
> > > Signed-off-by   : Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> > 
> > This is not valid.
> > 
> > > 
> > > v2:
> > >    - Add Signed-off-by.
> > >    - Removed ADM1278_TEMP1_EN check.
> > 
> > checkpatch reports:
> > 
> > > ---WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> > #14:
> > The adm1278 temperature sysfs attribute need it for one of the openbmc platform .
> > 
> > CHECK: Alignment should match open parenthesis
> > #45: FILE: drivers/hwmon/pmbus/adm1275.c:679:
> > +		ret = i2c_smbus_write_byte_data(client,
> > +					ADM1275_PMON_CONFIG,
> > 
> > WARNING: suspect code indent for conditional statements (16, 16)
> > #47: FILE: drivers/hwmon/pmbus/adm1275.c:681:
> > +		if (ret < 0) {
> > +		dev_err(&client->dev,
> > 
> > ERROR: Missing Signed-off-by: line(s)
> > 
> > total: 1 errors, 2 warnings, 1 checks, 33 lines checked
> > 
> > Please follow published guidelines when submitting patches.
> > 
> > >  drivers/hwmon/pmbus/adm1275.c | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> > > index 5caa37fb..ab5fceb 100644
> > > --- a/drivers/hwmon/pmbus/adm1275.c
> > > +++ b/drivers/hwmon/pmbus/adm1275.c
> > > @@ -666,7 +666,23 @@ static int adm1275_probe(struct i2c_client *client,
> > >  		tindex = 3;
> > >  
> > >  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> > > -			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> > > +			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> > > +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
> > > +
> > > +		config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
> > > +		if (config < 0)
> > > +			return config;
> > > +
> > > +		/* Enable TEMP1 by default */
> > > +		config |= ADM1278_TEMP1_EN;
> > > +		ret = i2c_smbus_write_byte_data(client,
> > > +					ADM1275_PMON_CONFIG,
> > > +					config);
> > > +		if (ret < 0) {
> > > +		dev_err(&client->dev,
> > > +			"Failed to enable temperature config\n");
> > > +		return -ENODEV;
> > > +		}
> > 
> > This can be handled in a single operation, together with ADM1278_VOUT_EN
> > below. There is no need for two separate write operations.
> >
>         Thanks for review Guenter, Patrick and Vijay.
>         Sorry for delay response. 
>         I have made changes to write ADM1278_VOUT_EN and ADM1278_TEMP1_EN in single
>         operation and tested in platfrom .
>         The changes given for quick look and will help if any misunderstand.
> 
> 	--- a/drivers/hwmon/pmbus/adm1275.c
> 	+++ b/drivers/hwmon/pmbus/adm1275.c
> 	@@ -666,11 +666,11 @@ static int adm1275_probe(struct i2c_client *client,
>  		tindex = 3;
>  
>  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> 	-			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> 	+			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT | 
>         +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  
>  		/* Enable VOUT if not enabled (it is disabled by default) */
>  		if (!(config & ADM1278_VOUT_EN)) {

		if (config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN) !=
						ADM1278_VOUT_EN | ADM1278_TEMP1_EN)

> 	-			config |= ADM1278_VOUT_EN;
> 	+			config |= (ADM1278_VOUT_EN | ADM1278_TEMP1_EN);

( ) is unnecessary here.

>  			ret = i2c_smbus_write_byte_data(client,
>  							ADM1275_PMON_CONFIG,
>  							config);
> 	@@ -680,10 +680,6 @@ static int adm1275_probe(struct i2c_client *client,
>  				return -ENODEV;
>  			}
>  		}
> 	-
> 	-		if (config & ADM1278_TEMP1_EN)
> 	-			info->func[0] |=
> 	-				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  		if (config & ADM1278_VIN_EN)
>  			info->func[0] |= PMBUS_HAVE_VIN;
>  		break; 
> > Guenter
> > 
> > > 
> > >  		/* Enable VOUT if not enabled (it is disabled by default) */
> > >  		if (!(config & ADM1278_VOUT_EN)) {
> > > @@ -681,9 +697,6 @@ static int adm1275_probe(struct i2c_client *client,
> > >  			}
> > >  		}
> > >  
> > > -		if (config & ADM1278_TEMP1_EN)
> > > -			info->func[0] |=
> > > -				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
> > >  		if (config & ADM1278_VIN_EN)
> > >  			info->func[0] |= PMBUS_HAVE_VIN;
> > >  		break;
> > > 
> > 
