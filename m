From: Manikandan <manikandan.hcl.ers.epl@gmail.com>
Date: Sat, 20 Jun 2020 10:23:15 +0530
Subject: Linux-aspeed Digest, Vol 37, Issue 25
In-Reply-To: <mailman.1431.1592592073.26230.linux-aspeed@lists.ozlabs.org>
References: <mailman.1431.1592592073.26230.linux-aspeed@lists.ozlabs.org>
Message-ID: <20200620045315.GA27844@cnn>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Jun 20, 2020 at 04:41:13AM +1000, linux-aspeed-request at lists.ozlabs.org wrote:
> Send Linux-aspeed mailing list submissions to
> 	linux-aspeed at lists.ozlabs.org
> 
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://lists.ozlabs.org/listinfo/linux-aspeed
> or, via email, send a message with subject or body 'help' to
> 	linux-aspeed-request at lists.ozlabs.org
> 
> You can reach the person managing the list at
> 	linux-aspeed-owner at lists.ozlabs.org
> 
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linux-aspeed digest..."
> 
> 
> Today's Topics:
> 
>    1. [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
>       (Manikandan Elumalai)
>    2. Re: [PATCH v4] hwmon:(adm1275) Enable adm1278
>       ADM1278_TEMP1_EN (Guenter Roeck)
>    3. [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
>       (Manikandan Elumalai)
>    4. Re:  [PATCH v4] hwmon:(adm1275) Enable adm1278
>       ADM1278_TEMP1_EN (Milton Miller II)
>    5. Re: [PATCH v4] hwmon:(adm1275) Enable adm1278
>       ADM1278_TEMP1_EN (Guenter Roeck)
> 
> 
> ----------------------------------------------------------------------
> 
> Message: 1
> Date: Fri, 19 Jun 2020 20:18:53 +0530
> From: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare
> 	<jdelvare@suse.com>, linux-hwmon at vger.kernel.org,
> 	linux-kernel at vger.kernel.org
> Cc: saipsdasari at fb.com, patrickw3 at fb.com, vijaykhemka at fb.com,
> 	linux-aspeed at lists.ozlabs.org, openbmc at lists.ozlabs.org,
> 	manikandan.e at hcl.com
> Subject: [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
> Message-ID: <20200619144853.GA18271@cnn>
> Content-Type: text/plain; charset=us-ascii
> 
> The adm1278 temp attribute need it for openbmc platform .
> This feature not enabled by default, so PMON_CONFIG needs to enable it.
> 
> v4:
> ---
> Reported-by: kernel test robot <lkp@intel.com>
> v3:
> ----
> fix invalid signed-off.
> removed checkpath warnings.
> write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
> v2:
> ----
> add Signed-off-by.
> removed ADM1278_TEMP1_EN check.
> 
> Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> ---
>  drivers/hwmon/pmbus/adm1275.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> index 5caa37fb..d4e1925 100644
> --- a/drivers/hwmon/pmbus/adm1275.c
> +++ b/drivers/hwmon/pmbus/adm1275.c
> @@ -666,11 +666,12 @@ static int adm1275_probe(struct i2c_client *client,
>  		tindex = 3;
>  
>  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> -			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> +			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  
> -		/* Enable VOUT if not enabled (it is disabled by default) */
> -		if (!(config & ADM1278_VOUT_EN)) {
> -			config |= ADM1278_VOUT_EN;
> +		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
> +		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) != (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
> +			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
>  			ret = i2c_smbus_write_byte_data(client,
>  							ADM1275_PMON_CONFIG,
>  							config);
> @@ -681,9 +682,6 @@ static int adm1275_probe(struct i2c_client *client,
>  			}
>  		}
>  
> -		if (config & ADM1278_TEMP1_EN)
> -			info->func[0] |=
> -				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  		if (config & ADM1278_VIN_EN)
>  			info->func[0] |= PMBUS_HAVE_VIN;
>  		break;
> -- 
> 2.7.4
> 
> 
> 
> ------------------------------
> 
> Message: 2
> Date: Fri, 19 Jun 2020 08:38:32 -0700
> From: Guenter Roeck <linux@roeck-us.net>
> To: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon at vger.kernel.org,
> 	linux-kernel at vger.kernel.org, saipsdasari at fb.com, patrickw3 at fb.com,
> 	vijaykhemka at fb.com, linux-aspeed at lists.ozlabs.org,
> 	openbmc at lists.ozlabs.org, manikandan.e at hcl.com
> Subject: Re: [PATCH v4] hwmon:(adm1275) Enable adm1278
> 	ADM1278_TEMP1_EN
> Message-ID: <20200619153832.GA57109@roeck-us.net>
> Content-Type: text/plain; charset=us-ascii
> 
> On Fri, Jun 19, 2020 at 08:18:53PM +0530, Manikandan Elumalai wrote:
> > The adm1278 temp attribute need it for openbmc platform .
> > This feature not enabled by default, so PMON_CONFIG needs to enable it.
> > 
> > v4:
> > ---
> > Reported-by: kernel test robot <lkp@intel.com>
> > v3:
> > ----
> > fix invalid signed-off.
> > removed checkpath warnings.
> > write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
> > v2:
> > ----
> > add Signed-off-by.
> > removed ADM1278_TEMP1_EN check.
> > 
> > Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> 
> The problem is that this is after '---', meaning it is considered a comment.
> The Signed-off-by: tag needs to be located before the first '---'.
> The change log should not be part of the commit log and follow '---'.
> 
> Guenter
> 
> > ---
> >  drivers/hwmon/pmbus/adm1275.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> > index 5caa37fb..d4e1925 100644
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
> > -		if (!(config & ADM1278_VOUT_EN)) {
> > -			config |= ADM1278_VOUT_EN;
> > +		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
> > +		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) != (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
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
> > -- 
> > 2.7.4
> > 
> 
> 
> ------------------------------
> 
> Message: 3
> Date: Fri, 19 Jun 2020 22:21:54 +0530
> From: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare
> 	<jdelvare@suse.com>, linux-hwmon at vger.kernel.org,
> 	linux-kernel at vger.kernel.org
> Cc: saipsdasari at fb.com, patrickw3 at fb.com, vijaykhemka at fb.com,
> 	linux-aspeed at lists.ozlabs.org, openbmc at lists.ozlabs.org,
> 	manikandan.e at hcl.com
> Subject: [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
> Message-ID: <20200619165154.GA20461@cnn>
> Content-Type: text/plain; charset=us-ascii
> 
> The adm1278 temp attribute need it for openbmc platform .
> This feature not enabled by default, so PMON_CONFIG needs to enable it.
> 
> Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> ---
> ---    v4 -Reported-by: kernel test robot <lkp@intel.com>
> ---    v3 -fix invalid signed-off.
> ---       -removed checkpath warnings.
> ---       -write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
> ---    v2 -add Signed-off-by.
> ---       -removed ADM1278_TEMP1_EN check.
> ---
> ---
>  drivers/hwmon/pmbus/adm1275.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> index 5caa37fb..d4e1925 100644
> --- a/drivers/hwmon/pmbus/adm1275.c
> +++ b/drivers/hwmon/pmbus/adm1275.c
> @@ -666,11 +666,12 @@ static int adm1275_probe(struct i2c_client *client,
>  		tindex = 3;
>  
>  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> -			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> +			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  
> -		/* Enable VOUT if not enabled (it is disabled by default) */
> -		if (!(config & ADM1278_VOUT_EN)) {
> -			config |= ADM1278_VOUT_EN;
> +		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
> +		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) != (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
> +			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
>  			ret = i2c_smbus_write_byte_data(client,
>  							ADM1275_PMON_CONFIG,
>  							config);
> @@ -681,9 +682,6 @@ static int adm1275_probe(struct i2c_client *client,
>  			}
>  		}
>  
> -		if (config & ADM1278_TEMP1_EN)
> -			info->func[0] |=
> -				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  		if (config & ADM1278_VIN_EN)
>  			info->func[0] |= PMBUS_HAVE_VIN;
>  		break;
> -- 
> 2.7.4
> 
> 
> 
> ------------------------------
> 
> Message: 4
> Date: Fri, 19 Jun 2020 18:09:55 +0000
> From: "Milton Miller II" <miltonm@us.ibm.com>
> To: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare
> 	<jdelvare@suse.com>, linux-hwmon at vger.kernel.org,
> 	linux-kernel at vger.kernel.org, manikandan.e at hcl.com,
> 	linux-aspeed at lists.ozlabs.org, openbmc at lists.ozlabs.org,
> 	vijaykhemka at fb.com, saipsdasari at fb.com, patrickw3 at fb.com
> Subject: Re:  [PATCH v4] hwmon:(adm1275) Enable adm1278
> 	ADM1278_TEMP1_EN
> Message-ID:
> 	<OFB20C104E.283BBF6D-ON0025858C.0062CC5B-0025858C.0063C8F2@notes.na.collabserv.com>
> 	
> Content-Type: text/plain; charset=UTF-8
> 
> On : 06/19/2020 abiout 12:46PM in some timezone,  Manikandan Elumalai  wrote:
> 
> >The adm1278 temp attribute need it for openbmc platform .
> >This feature not enabled by default, so PMON_CONFIG needs to enable
> >it.
> >
> >Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> >---
> >---    v4 -Reported-by: kernel test robot <lkp@intel.com>
> 
> Thie above tag should be Adjacent to the Signed-off-by.

     Thanks for review Milton.I will update new patch v6.
> 
> >---    v3 -fix invalid signed-off.
> >---       -removed checkpath warnings.
> >---       -write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single
> >line operation.
> >---    v2 -add Signed-off-by.
> >---       -removed ADM1278_TEMP1_EN check.
> >---
> 
> The canonical format is to have a line of 3 dashes then the trailing changelog 
> 
  will do.
> Please read the documentation at 
> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format
> 
> milton
> 
> 
> 
> ------------------------------
> 
> Message: 5
> Date: Fri, 19 Jun 2020 11:41:03 -0700
> From: Guenter Roeck <linux@roeck-us.net>
> To: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>, Jean
> 	Delvare <jdelvare@suse.com>, linux-hwmon at vger.kernel.org,
> 	linux-kernel at vger.kernel.org
> Cc: saipsdasari at fb.com, patrickw3 at fb.com, vijaykhemka at fb.com,
> 	linux-aspeed at lists.ozlabs.org, openbmc at lists.ozlabs.org,
> 	manikandan.e at hcl.com
> Subject: Re: [PATCH v4] hwmon:(adm1275) Enable adm1278
> 	ADM1278_TEMP1_EN
> Message-ID: <fa65b6de-b7ea-894b-7fd1-47676cc3c705@roeck-us.net>
> Content-Type: text/plain; charset=utf-8
> 
> On 6/19/20 9:51 AM, Manikandan Elumalai wrote:
> > The adm1278 temp attribute need it for openbmc platform .
> > This feature not enabled by default, so PMON_CONFIG needs to enable it.
> > 
> > Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> 
> In addition to the other comment - please never send a new version of a patch
> with the same sequence number. There are now two different versions of this patch,
> both tagged "v4".
> 
> Guenter
> 
> > ---
> > ---    v4 -Reported-by: kernel test robot <lkp@intel.com>
> > ---    v3 -fix invalid signed-off.
> > ---       -removed checkpath warnings.
> > ---       -write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
> > ---    v2 -add Signed-off-by.
> > ---       -removed ADM1278_TEMP1_EN check.
> > ---
> > ---
> >  drivers/hwmon/pmbus/adm1275.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> > index 5caa37fb..d4e1925 100644
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
> > -		if (!(config & ADM1278_VOUT_EN)) {
> > -			config |= ADM1278_VOUT_EN;
> > +		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
> > +		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) != (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
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
> 
> 
> ------------------------------
> 
> Subject: Digest Footer
> 
> _______________________________________________
> Linux-aspeed mailing list
> Linux-aspeed at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linux-aspeed
> 
> 
> ------------------------------
> 
> End of Linux-aspeed Digest, Vol 37, Issue 25
> ********************************************
