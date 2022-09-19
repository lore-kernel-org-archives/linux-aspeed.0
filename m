From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 19 Sep 2022 06:13:05 -0700
Subject: [PATCH] hwmon: (aspeed-pwm-tacho): Add dependency on ARCH_ASPEED
In-Reply-To: <20220916120936.372591-1-pbrobinson@gmail.com>
References: <20220916120936.372591-1-pbrobinson@gmail.com>
Message-ID: <20220919131305.GA3545921@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 16, 2022 at 01:09:36PM +0100, Peter Robinson wrote:
> The SENSORS_ASPEED is part of the Aspeed silicon so it makes
> sense to depend on ARCH_ASPEED and for compile testing.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Applied.

Thanks,
Guenter
