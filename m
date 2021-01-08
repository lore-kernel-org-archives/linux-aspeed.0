From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 8 Jan 2021 07:35:40 -0800
Subject: [PATCH] hwmon: (aspeed-pwm-tacho): Switch to using the new API
 kobj_to_dev()
In-Reply-To: <1609725945-13895-1-git-send-email-tiantao6@hisilicon.com>
References: <1609725945-13895-1-git-send-email-tiantao6@hisilicon.com>
Message-ID: <20210108153540.GA4766@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 04, 2021 at 10:05:45AM +0800, Tian Tao wrote:
> fixed the following coccicheck:
> drivers/hwmon/aspeed-pwm-tacho.c:634:60-61: WARNING opportunity for
> kobj_to_dev()
> drivers/hwmon/aspeed-pwm-tacho.c:623:60-61: WARNING opportunity for
> kobj_to_dev()
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Acked-by: Joel Stanley <joel@jms.id.au>

Applied.

Thanks,
Guenter
