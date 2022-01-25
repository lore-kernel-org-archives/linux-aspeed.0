From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 25 Jan 2022 06:46:28 -0800
Subject: [PATCH linux dev-5.15] hwmon: (pmbus) modify PSU fan_target
 convert value to false
In-Reply-To: <20220125130116.18646-1-krishnar@ami.com>
References: <20220125130116.18646-1-krishnar@ami.com>
Message-ID: <4e7ca9d8-c545-160a-5578-cf1438223759@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/25/22 05:01, krishnar4 wrote:
> Description: PSU can't use sysfs fan_target to control PSU fan duty.
> 

This is neither a proper subject nor a proper description.
"modify PSU fan_target convert value to false" means that the
value reported from the attribute is used directly without
conversion. The subject should reflect this.
"Description:" should not be part of the description, and
the description should describe the reason for the change
(ie explain clearly what is wrong).
"PSU can't use sysfs fan_target to control PSU fan duty"
doesn't explain anything and doesn't match the subject.

> Signed-off-by: krishnar4 <krishnar@ami.com>

"krishnar4" is not an acceptable name. This needs to be a real name.

Guenter

> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 776ee2237be2..a56c2e1c4079 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -1889,7 +1889,7 @@ static int pmbus_add_fan_ctrl(struct i2c_client *client,
>   
>   	sensor = pmbus_add_sensor(data, "fan", "target", index, page,
>   				  0xff, PMBUS_VIRT_FAN_TARGET_1 + id, PSC_FAN,
> -				  false, false, true);
> +				  false, false, false);
>   
>   	if (!sensor)
>   		return -ENOMEM;

