Return-Path: <linux-aspeed+bounces-2391-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2C7CCD183
	for <linux-aspeed@archiver.kernel.org>; Fri,  3 Oct 2025 14:16:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cdW1g3jz8z3cyd;
	Sat,  4 Oct 2025 00:16:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.176.79.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759500999;
	cv=none; b=d5OjCeYWfJbp0di5X6HszkMzbnoE5aFsni2dCgozaP2SQTbvO9KsX/4EfTHAelM0kygIqiLSLxE0bkjW+N8z0JTN+ZwN6LQ/VF2QflzCMjX7aayz/GcOKfd5I8mnXzE6uP/dvTW16w30/Qt7psqtsGCn0S8h1f4JvCe2aNfMDy+45/dSjLCLsvlMb3dc06sm26sfxB1PTG6CLOsouYMhrT5PzZZa38uGBDO4Xt1Y+lSKSKR4iC+bvxnY8GGUhJnK/02AN+gltdNhjc0nqGejng+X2e5qPjDRnaffVskVR3BZQ6RMUeWlAWAI5I816My+1l9CIRWuQqkj36p5MLngOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759500999; c=relaxed/relaxed;
	bh=M6IfhhopAWfN0BJm01h1j2uMKBn0lMJ49zFtBXPEhsQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JImWEjckSIxA6X9c5cbH4VbRKFzCPJufX8XfjfouhKoC60HqJsYofrIEeZV43tPjRTQuuOAtRoIxJNL0ZbLCR8grwW48YNBRojkATS+pYMZw5sRxIlUu5SqS7oKpLBXGSyjgNiPFYk7N95e8RwiTU8c93LtSySJ991Qs6F5UkJLYos02F+PfECONjfvcRgIsVt+nGA0XwTOoWA43h/0z/QB4OPHXA9Cm8fzXLUHOAPxPB/VRCPmc6PZtMoeM5HgW40naYqLS/SYW0jV9HPDN0GJpYyyIks0s2uKlOJcSmCWiJGYHAtfoIJ0OU1ZA3w/uaH7zDICa+11TL9hQX9ERAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 925 seconds by postgrey-1.37 at boromir; Sat, 04 Oct 2025 00:16:37 AEST
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cdW1d5shvz3cYP
	for <linux-aspeed@lists.ozlabs.org>; Sat,  4 Oct 2025 00:16:35 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cdVgF2bRxz6L4tn;
	Fri,  3 Oct 2025 22:00:41 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AF2114044F;
	Fri,  3 Oct 2025 22:01:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Oct
 2025 15:01:03 +0100
Date: Fri, 3 Oct 2025 15:01:02 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Eddie James <eajames@linux.ibm.com>
CC: <linux-hwmon@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <andrew@codeconstruct.com.au>, <joel@jms.id.au>,
	<linux@roeck-us.net>, <chanh@os.amperecomputing.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>
Subject: Re: [PATCH v7 RESEND 3/7] dt-bindings: iio: Add Infineon DPS310
 sensor documentation
Message-ID: <20251003150102.00007dae@huawei.com>
In-Reply-To: <20251001144441.310950-4-eajames@linux.ibm.com>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
	<20251001144441.310950-4-eajames@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed,  1 Oct 2025 09:44:37 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> The DPS310 is a barometric pressure and temperature sensor with
> an I2C interface. Remove it from trivial-devices.yaml and add its
> own documentation.

Hi Eddie,

Why?  I guess you need the #io-channel-cells which trivial devices
doesn't allow because you have a consumer driver?

Obviously the binding patch shouldn't mention that, but it could call
out that there can be such consumers.

I'd also expect to see some supplies even if the driver doesn't yet
explicitly handle them.

Jonathan

> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../iio/pressure/infineon,dps310.yaml         | 44 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  MAINTAINERS                                   |  1 +
>  3 files changed, 45 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> new file mode 100644
> index 0000000000000..7c0782e2a821b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/infineon,dps310.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Infineon DPS310 barometric pressure and temperature sensor
> +
> +maintainers:
> +  - Eddie James <eajames@linux.ibm.com>
> +
> +description:
> +  The DPS310 is a barometric pressure and temperature sensor with an I2C
> +  interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - infineon,dps310
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#io-channel-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pressure-sensor@76 {
> +          compatible = "infineon,dps310";
> +          reg = <0x76>;
> +          #io-channel-cells = <0>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 7609acaa752d5..a72b7fabc7034 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -127,8 +127,6 @@ properties:
>            - ibm,cffps2
>              # IBM On-Chip Controller hwmon device
>            - ibm,p8-occ-hwmon
> -            # Infineon barometric pressure and temperature sensor
> -          - infineon,dps310
>              # Infineon IR36021 digital POL buck controller
>            - infineon,ir36021
>              # Infineon IRPS5401 Voltage Regulator (PMIC)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c8281ea4cc64..92b9854a0e07d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12191,6 +12191,7 @@ INFINEON DPS310 Driver
>  M:	Eddie James <eajames@linux.ibm.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
>  F:	drivers/iio/pressure/dps310.c
>  
>  INFINEON PEB2466 ASoC CODEC


