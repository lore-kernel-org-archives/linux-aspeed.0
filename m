From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 10 Feb 2022 13:11:13 +0200
Subject: [PATCH] serial: 8250_aspeed_vuart: add PORT_ASPEED_VUART port type
In-Reply-To: <20220209203414.23491-1-zev@bewilderbeest.net>
References: <20220209203414.23491-1-zev@bewilderbeest.net>
Message-ID: <CAHp75VdyNsrm8oeO0KvyPXNR23VdQEMd9LHks20bLbkE_g7kuw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 9, 2022 at 10:53 PM Zev Weiss <zev@bewilderbeest.net> wrote:

...

> +/* ASPEED AST2x00 virtual UART */
> +#define PORT_ASPEED_VUART      123

If you are going to put it here, use the existing gap first, no need
to expand the last number.

-- 
With Best Regards,
Andy Shevchenko
