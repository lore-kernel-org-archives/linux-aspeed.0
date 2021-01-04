From: Joel Stanley <joel@jms.id.au>
Date: Mon, 4 Jan 2021 02:12:58 +0000
Subject: [PATCH] hwmon: (aspeed-pwm-tacho): Switch to using the new API
 kobj_to_dev()
In-Reply-To: <1609725945-13895-1-git-send-email-tiantao6@hisilicon.com>
References: <1609725945-13895-1-git-send-email-tiantao6@hisilicon.com>
Message-ID: <CACPK8XdvL9yacNKkZ4Ut8b2m9jFrMv=Ri-8qn1DSu0547ZecGw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 4 Jan 2021 at 02:05, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> fixed the following coccicheck:
> drivers/hwmon/aspeed-pwm-tacho.c:634:60-61: WARNING opportunity for
> kobj_to_dev()
> drivers/hwmon/aspeed-pwm-tacho.c:623:60-61: WARNING opportunity for
> kobj_to_dev()
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Acked-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/hwmon/aspeed-pwm-tacho.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
> index 3d8239f..3cb88d6 100644
> --- a/drivers/hwmon/aspeed-pwm-tacho.c
> +++ b/drivers/hwmon/aspeed-pwm-tacho.c
> @@ -620,7 +620,7 @@ static ssize_t rpm_show(struct device *dev, struct device_attribute *attr,
>  static umode_t pwm_is_visible(struct kobject *kobj,
>                               struct attribute *a, int index)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct aspeed_pwm_tacho_data *priv = dev_get_drvdata(dev);
>
>         if (!priv->pwm_present[index])
> @@ -631,7 +631,7 @@ static umode_t pwm_is_visible(struct kobject *kobj,
>  static umode_t fan_dev_is_visible(struct kobject *kobj,
>                                   struct attribute *a, int index)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct aspeed_pwm_tacho_data *priv = dev_get_drvdata(dev);
>
>         if (!priv->fan_tach_present[index])
> --
> 2.7.4
>
