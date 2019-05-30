From: Joel Stanley <joel@jms.id.au>
Date: Thu, 30 May 2019 14:16:59 +0000
Subject: [PATCH] ARM: dts: aspeed: Add YADRO VESNIN BMC
In-Reply-To: <20190530093948.12479-1-a.filippov@yadro.com>
References: <20190530093948.12479-1-a.filippov@yadro.com>
Message-ID: <CACPK8XfG7j4Z2bqX9CFxUeUrpx708Uqbh-5ts9W5SnDfDw-xYA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2019 at 09:40, Alexander Filippov <a.filippov@yadro.com> wrote:
> @@ -0,0 +1,262 @@

Can we get a SDPX license string at the top of the file? Something like this:

// SPDX-License-Identifier: GPL-2.0+
// Copyright 2019 <copyright holder>

> +/dts-v1/;
> +
> +#include "aspeed-g4.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +

> +&i2c3 {
> +       status = "okay";
> +       cpr2021 at 59 {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               compatible = "general,cpr2021", "general,pmbus";

Do you have a driver for this one you plan on submitting?
