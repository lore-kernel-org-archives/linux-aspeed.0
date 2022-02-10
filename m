From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 10 Feb 2022 13:13:28 +0200
Subject: [PATCH v2] serial: 8259_aspeed_vuart: replace snprintf with
 sysfs_emit
In-Reply-To: <a0f3e5d6d438710413d1909365f99ae4d2a4bacc.1644399683.git.yang.guang5@zte.com.cn>
References: <a0f3e5d6d438710413d1909365f99ae4d2a4bacc.1644399683.git.yang.guang5@zte.com.cn>
Message-ID: <CAHp75Vd-Zszg1j6aVrX_oEJdiq4m=69JqE4RvyPMqEu30RFaTA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 10, 2022 at 12:54 PM <davidcomponentone@gmail.com> wrote:
>
> From: Yang Guang <yang.guang5@zte.com.cn>
>
> coccinelle report:
> ./drivers/tty/serial/8250/8250_aspeed_vuart.c:85:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/tty/serial/8250/8250_aspeed_vuart.c:174:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/tty/serial/8250/8250_aspeed_vuart.c:127:8-16:
> WARNING: use scnprintf or sprintf
>
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.

sysfs_emit()
scnprintf()
sprintf()

...

> CC: David Yang <davidcomponentone@gmail.com>

> - Use the CC for patch sender

This is incorrect. The submitter must have (the last) SoB tag.
Question was about authorship just to be clear.

-- 
With Best Regards,
Andy Shevchenko
