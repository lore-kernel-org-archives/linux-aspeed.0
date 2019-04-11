From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 10 Apr 2019 20:27:41 -0400
Subject: =?UTF-8?Q?Re:_[PATCH_v2_10/21]_docs:_hwmon:_aspeed-pwm-tacho:_convert_to?=
 =?UTF-8?Q?_ReST_format?=
In-Reply-To: <2088d3de719397153639c5afdce53b73fe75603a.1554923967.git.mchehab+samsung@kernel.org>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <2088d3de719397153639c5afdce53b73fe75603a.1554923967.git.mchehab+samsung@kernel.org>
Message-ID: <e2b1820f-070e-4d8d-81d2-6dd8f564a861@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 11 Apr 2019, at 04:54, Mauro Carvalho Chehab wrote:
> Convert aspeed-pwm-tacho to ReST format, in order to allow it to
> be parsed by Sphinx.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  Documentation/hwmon/aspeed-pwm-tacho | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/hwmon/aspeed-pwm-tacho 
> b/Documentation/hwmon/aspeed-pwm-tacho
> index 7cfb34977460..6dcec845fbc7 100644
> --- a/Documentation/hwmon/aspeed-pwm-tacho
> +++ b/Documentation/hwmon/aspeed-pwm-tacho
> @@ -15,8 +15,10 @@ controller supports up to 16 tachometer inputs.
>  
>  The driver provides the following sensor accesses in sysfs:
>  
> +=============== ======= =====================================================
>  fanX_input	ro	provide current fan rotation value in RPM as reported
>  			by the fan to the device.
>  
>  pwmX		rw	get or set PWM fan control value. This is an integer
>  			value between 0(off) and 255(full speed).
> +=============== ======= =====================================================
> -- 
> 2.20.1
> 
>
