From: Manikandan <manikandan.hcl.ers.epl@gmail.com>
Date: Tue, 9 Jun 2020 20:56:28 +0530
Subject: [PATCH v3] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
In-Reply-To: <23597b7b-de89-2911-092e-f3e1ad4884f5@roeck-us.net>
References: <20200608104349.GA10918@cnn>
 <23597b7b-de89-2911-092e-f3e1ad4884f5@roeck-us.net>
Message-ID: <20200609152628.GB8833@cnn>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 08, 2020 at 06:49:45AM -0700, Guenter Roeck wrote:
> On 6/8/20 3:43 AM, Manikandan Elumalai wrote:
> > The adm1278 temp attribute need it for openbmc platform .
> > This feature not enabled by default, so PMON_CONFIG needs to enable it.
> > 
> > v3:
> > ----
> > fix invalid signed-off.
> > removed checkpath warnings.
> > write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
> > 
> > v2:
> > ----
> > add Signed-off-by.
> > removed ADM1278_TEMP1_EN check.
> > 
> > Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> > ---
> >  drivers/hwmon/pmbus/adm1275.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> > index 5caa37fb..4782e31 100644
> > --- a/drivers/hwmon/pmbus/adm1275.c
> > +++ b/drivers/hwmon/pmbus/adm1275.c
> > @@ -666,11 +666,12 @@ static int adm1275_probe(struct i2c_client *client,
> >  		tindex = 3;
> >  
> >  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> > -			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> > +			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> > +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
> >  
> > -		/* Enable VOUT if not enabled (it is disabled by default) */
> > +		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
> >  		if (!(config & ADM1278_VOUT_EN)) {
> 
> This if statement needs to be
> 		if (config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN) != ADM1278_VOUT_EN | ADM1278_TEMP1_EN)
>
          Hi Guenter,

             The below warning shown by checkpatch after changes,

                  WARNING: line over 80 characters
                   #38: FILE: drivers/hwmon/pmbus/adm1275.c:672:
                   + if (config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN) != ADM1278_VOUT_EN | ADM1278_TEMP1_EN) {
 
                   total: 0 errors, 1 warnings, 24 lines checked

              I didn't see any if() condition made as two line in the driver . Is this acceptable warning ?

         Thanks
         Mani.E
> > -			config |= ADM1278_VOUT_EN;
> > +			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
> >  			ret = i2c_smbus_write_byte_data(client,
> >  							ADM1275_PMON_CONFIG,
> >  							config);
> > @@ -681,9 +682,6 @@ static int adm1275_probe(struct i2c_client *client,
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
