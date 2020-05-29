From: Patrick Williams <patrick@stwcx.xyz>
Date: Fri, 29 May 2020 07:49:38 -0500
Subject: [PATCH] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
In-Reply-To: <20200528141523.GA8810@cnn>
References: <20200528141523.GA8810@cnn>
Message-ID: <20200529124938.GE17541@heinlein>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 28, 2020 at 07:45:23PM +0530, Manikandan Elumalai wrote:

Hi Manikandan,

Adding the PMBus maintainers...

> 
> The adm1278 temperature sysfs attribute need it for one of the our openbmc platform . 
> This functionality is not enabled by default, so PMON_CONFIG needs to be modified in order to enable it.

Vijay already mentioned the Signed-off-by here.

Since this is a kernel patch and your first time contributing one, please
read through:
    https://www.kernel.org/doc/html/latest/process/1.Intro.html
and the MAINTAINERS file.  Another thing you've missed is using the
get_maintainer.pl script to find out who you're suppose to CC.  It is
fine to have additional CCs but we're missing the pmbus maintainer on
this patch.

> 
> ---
>  drivers/hwmon/pmbus/adm1275.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> index 5caa37fb..47b293d 100644
> --- a/drivers/hwmon/pmbus/adm1275.c
> +++ b/drivers/hwmon/pmbus/adm1275.c
> @@ -681,6 +681,21 @@ static int adm1275_probe(struct i2c_client *client,
>  			}
>  		}
>  
> +		config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
> +		if (config < 0)
> +			return config;
> +
> +		/* Enable TEMP1 by defult */
> +		config |= ADM1278_TEMP1_EN;
> +		ret = i2c_smbus_write_byte_data(client,
> +					ADM1275_PMON_CONFIG,
> +					config);
> +		if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to enable temperature config\n");
> +		return -ENODEV;
> +		}
> +

This code might work for your design, but likely doesn't work for
everyone and isn't likely to be accepted in its current state.  I think
you need some kind of detection logic here to know if TEMP1_EN *should*
be enabled.  Do we need a device-tree entry for this?


>  		if (config & ADM1278_TEMP1_EN)
>  			info->func[0] |=
>  				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
> -- 
> 2.7.4
> 

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200529/d3c35d29/attachment.sig>
