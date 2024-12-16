Return-Path: <linux-aspeed+bounces-254-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DBDE7717F
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Dec 2024 18:26:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBpKz4tNYz2yyT;
	Tue, 17 Dec 2024 05:26:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734373575;
	cv=none; b=NB9P8vJ/wwx9QwUK0XnxtbQ6wuij8v5UiPNe+jJjy4tKsg0x/PNCbmixLzOQqsUI3NJHUfsIMnZs8CQcB5MSzUvO+sD8OpXnvNMsGtwMbBj+gI5ytsmtO1FBLLEDHjwdZZ/CEBWfXa8HENzM5nvhxW4IKnqjAGUcYKnwwPsFEaBaKzgksPkZMQQGUcA4iHtuyhgRVWuxSh6Nfav/uKaYmKrgt6KcZgParWxvwDzXVuZgkRNxSuIvopX2EmgY4t13prtS6GLio6kKEhic1Bv1WT8IN0VqEBU6wqNg96PQGmaMcA6Kj1K/3AAS41f0RAzyPNmwlmkBT9vMwpRwfTKe8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734373575; c=relaxed/relaxed;
	bh=z5v6t5ZdFhmDa6zhk8r3XLWydriletRBT370Ih+VX4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fDfH3GYOodf62bto+ZwTz6EfulgzWPw/X2s9/PUsPWNlCk1yXPgAOsy8FUiQAH/u1Teolo9ZTstpbehE2RcZa52ekhOK0LYojDdkq0k6fsa1K0Dhw1eeODVbosP6XMH7w9V+V0sJmkeGbm0y5SRJAfkA+m0uy4bHuPJ750guRQVXpPFFFZrwNxS87+mv8lepjAnOjbW52g1N7iZRCmnL2MB09m1mp7nbf5UCZF2WkJtVHJjm+neMQGprr7DFxqa8W/nCwg3XcFooLRPcYAXwU5kIM5gCkCel59aZ361MeCMsexWgQOd1eRMs3ivJ/KSFbHFUnALXqMMdE/wIik7A+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JLfEGAaC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JLfEGAaC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBpKx5JVhz2yhT
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Dec 2024 05:26:12 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-21680814d42so37153305ad.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Dec 2024 10:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734373569; x=1734978369; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=z5v6t5ZdFhmDa6zhk8r3XLWydriletRBT370Ih+VX4A=;
        b=JLfEGAaCDa2Efi2xS6f0bl3ZoDM5zkH4Jp9G6+4hdM4yzTVj/5UkvFzCE/qBkIz+Nz
         ogQOc8pSZXQ7C2Bl+bCIo5hiH9Ht6RM0DoRsa+Aq4Eb/jz9oqxcYGiCOkphpLjzQ2fTm
         q2dVNzBdCM5ZD03ZEOZOiqT0WlxIdgaTZ7su9WugfE8tTHTF8SciUR/5KuOAfpmGz/R7
         mkPrsUXa5ZdgoI27u5qOiMp0GKGkTD9Co3rTyzycNs/ZX6mjNmYTt+XZxdHP1M29F5qn
         Nurkt9UULAXBwKNhmo36m54SQrFsszeu3DMnq7uXj0GDOLVB9JedcKLoxMGAbOtLZUpL
         y31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734373569; x=1734978369;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5v6t5ZdFhmDa6zhk8r3XLWydriletRBT370Ih+VX4A=;
        b=wIOqkJDi/+wGPM73J1YuL+rvP5V2TsUDw5UK6rtHqwp1PMmGNG3JHUa3F0RVphXRlG
         KzfEszPUtSKbm9+0HROEox4V53ijvH62sa6LG4P+FenXAf7J0mqygfKcY8IhS3MO/dTd
         Apt6GlgZ77vqwpi6kSQvDJ96UuVs8DW+tlP1FmR69iyhmreuBtZp6CusOJpXH7MGj2cX
         KbHofSO66PA9oz5wK8VNhkHpnwlw02woKXowZk97GOErFH1NHfSUEQEeCnxpFz2h3iOu
         O8ONGcY+CxVI/3suConkKT1LXW8Koc2NERvudkV90VM/S7EPKPyIcxAcLtvum7qh5zlx
         mH3g==
X-Forwarded-Encrypted: i=1; AJvYcCUD6mCMLq06F4+eLH2ePNaXjNrdgVlm3Q/q5VXfChaRuqSzqa7b9CigSQw1mPMvKUtvdkhoMWfGgKxlnEM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxIdfM0mZnLRP+jvJVC3JI0tICkMxsuliSnS3l4CNXvfnVluQKx
	YEfF8bHqO0ewns325NrPpi44OxX2E9SwuNGjJEKIfllvaBv8CDwh
X-Gm-Gg: ASbGnctlMD38LHMb4OnS6W4KzjREi32Wk7V0Swixz2nL2EliKV2A7WtiKmaq/n6IjkP
	HZR6Hd8TRyy1VDxvYSf90UODfKXGJj0LCV/YABm9rbFvghOG90/QiksL3UWLIrtgJcvl85nr7R7
	Tz05seqttMaaM02bAZOWOnj8sjCGSoMrXuJlOA3PwXJp3ukgyk+Ws1d/GGdWH0O8auG57javpFC
	96/VxYFIfnuSG/WwAWaGKEQA2z9C1egbO9O0QlubQF1O0ZZ3mzlSvr2gnsovbdhmCX0eDokl37J
	Nknh687jOJ7XqOyTdJfXwx8uhUV9Yw==
X-Google-Smtp-Source: AGHT+IFXMO5qxLvZjW18H2LzV2nIClKzOZD7sng6ZospOJmztB1yGV9lAuTs4U+9rB751t7NG8nvgQ==
X-Received: by 2002:a17:902:ecc4:b0:216:69ca:7707 with SMTP id d9443c01a7336-21892a028d9mr169367855ad.30.1734373569238;
        Mon, 16 Dec 2024 10:26:09 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e4ffd9sm46010555ad.142.2024.12.16.10.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 10:26:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <68f5d2e1-10e8-4441-9338-e2a385a9c2b1@roeck-us.net>
Date: Mon, 16 Dec 2024 10:26:06 -0800
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hwmon: (pmbus/crps) Add Intel CRPS185 power supply
To: Ninad Palsule <ninad@linux.ibm.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, eajames@linux.ibm.com, jdelvare@suse.com,
 corbet@lwn.net, joel@jms.id.au, andrew@codeconstruct.com.au,
 Delphine_CC_Chiu@Wiwynn.com, broonie@kernel.org, peteryin.openbmc@gmail.com,
 noahwang.wang@outlook.com, naresh.solanki@9elements.com, lukas@wunner.de,
 jbrunet@baylibre.com, patrick.rudolph@9elements.com,
 gregkh@linuxfoundation.org, peterz@infradead.org, pbiel7@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-i2c@vger.kernel.org
References: <20241216175044.4144442-1-ninad@linux.ibm.com>
 <20241216175044.4144442-3-ninad@linux.ibm.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241216175044.4144442-3-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 09:50, Ninad Palsule wrote:
> Add the driver to monitor Intel common redundant power supply (crps185)
> with hwmon over pmbus.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   Documentation/hwmon/crps.rst  | 97 +++++++++++++++++++++++++++++++++++
>   Documentation/hwmon/index.rst |  1 +
>   MAINTAINERS                   |  7 +++
>   drivers/hwmon/pmbus/Kconfig   |  9 ++++
>   drivers/hwmon/pmbus/Makefile  |  1 +
>   drivers/hwmon/pmbus/crps.c    | 79 ++++++++++++++++++++++++++++
>   6 files changed, 194 insertions(+)
>   create mode 100644 Documentation/hwmon/crps.rst
>   create mode 100644 drivers/hwmon/pmbus/crps.c
> 
> diff --git a/Documentation/hwmon/crps.rst b/Documentation/hwmon/crps.rst
> new file mode 100644
> index 000000000000..74570ed1e978
> --- /dev/null
> +++ b/Documentation/hwmon/crps.rst
> @@ -0,0 +1,97 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver crps
> +==================
> +
> +Supported chips:
> +
> +  * Intel CRPS185
> +
> +    Prefix: 'crps185'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: Publicly not available.

Maybe "Only available under NDA". Or at least that is what I found.

> +
> +Authors:
> +    Ninad Palsule <ninad@linux.ibm.com>
> +
> +
> +Description
> +-----------
> +
> +This driver implements support for Intel Common Redundant Power supply with
> +PMBus support.
> +
> +The driver is a client driver to the core PMBus driver.
> +Please see Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
> +
> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate the
> +devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
> +details.
> +
> +
> +Sysfs entries
> +-------------
> +
> +======================= ======================================================
> +curr1_label		"iin"
> +curr1_input		Measured input current
> +curr1_max		Maximum input current
> +curr1_max_alarm         Input maximum current high alarm
> +curr1_crit              Critial high input current
> +curr1_crit_alarm        Input critical current high alarm
> +curr1_rated_max		Maximum rated input current
> +
> +curr2_label		"iout1"
> +curr2_input		Measured output current
> +curr2_max		Maximum output current
> +curr2_max_alarm         Output maximum current high alarm
> +curr2_crit	        Critial high output current
> +curr2_crit_alarm        Output critical current high alarm
> +curr2_rated_max		Maximum rated output current
> +
> +in1_label		"vin"
> +in1_input		Measured input voltage
> +in1_crit                Critical input over voltage
> +in1_crit_alarm          Critical input over voltage alarm
> +in1_max                 Maximum input over voltage
> +in1_max_alarm           Maximum input over voltage alarm
> +in1_rated_min		Minimum rated input voltage
> +in1_rated_max		Maximum rated input voltage
> +
> +in2_label		"vout1"
> +in2_input		Measured input voltage
> +in2_crit                Critical input over voltage
> +in2_crit_alarm          Critical input over voltage alarm
> +in2_lcrit               Critical input under voltage fault
> +in2_lcrit_alarm         Critical input under voltage fault alarm
> +in2_max                 Maximum input over voltage
> +in2_max_alarm           Maximum input over voltage alarm
> +in2_min                 Minimum input under voltage warning
> +in2_min_alarm           Minimum input under voltage warning alarm
> +in2_rated_min		Minimum rated input voltage
> +in2_rated_max		Maximum rated input voltage
> +
> +power1_label		"pin"
> +power1_input		Measured input power
> +power1_alarm		Input power high alarm
> +power1_max  		Maximum input power
> +power1_rated_max        Maximum rated input power
> +
> +temp[1-2]_input		Measured temperature
> +temp[1-2]_crit 		Critical temperature
> +temp[1-2]_crit_alarm    Critical temperature alarm
> +temp[1-2]_max  		Maximum temperature
> +temp[1-2]_max_alarm     Maximum temperature alarm
> +temp[1-2]_rated_max     Maximum rated temperature
> +
> +fan1_alarm		Fan 1 warning.
> +fan1_fault		Fan 1 fault.
> +fan1_input		Fan 1 speed in RPM.
> +fan1_target             Fan 1 target.
> +======================= ======================================================

Does this pass "make htmldocs" ?


> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 1a3cb0a59f72..b1ea445479b0 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -58,6 +58,7 @@ Hardware Monitoring Kernel Drivers
>      corsair-cpro
>      corsair-psu
>      cros_ec_hwmon
> +   crps
>      da9052
>      da9055
>      dell-smm-hwmon
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 637ddd44245f..e99f26f75733 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6100,6 +6100,13 @@ L:	linux-input@vger.kernel.org
>   S:	Maintained
>   F:	drivers/hid/hid-creative-sb0540.c
>   
> +INTEL CRPS COMMON REDUNDANT PSU DRIVER
> +M:	Ninad Palsule <ninad@linux.ibm.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/crps.rst
> +F:	drivers/hwmon/pmbus/crps.c
> +
>   CRYPTO API
>   M:	Herbert Xu <herbert@gondor.apana.org.au>
>   M:	"David S. Miller" <davem@davemloft.net>
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 22418a05ced0..43b6df04e0f9 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -85,6 +85,15 @@ config SENSORS_BPA_RS600
>   	  This driver can also be built as a module. If so, the module will
>   	  be called bpa-rs600.
>   
> +config SENSORS_CRPS
> +	tristate "Intel Common Redundant Power Supply"
> +	help
> +	  If you say yes here you get hardware monitoring support for the Intel
> +	  Common Redundant Power Supply.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called crps.
> +
>   config SENSORS_DELTA_AHE50DC_FAN
>   	tristate "Delta AHE-50DC fan control module"
>   	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 3d3183f8d2a7..c7eb7739b7f8 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -62,3 +62,4 @@ obj-$(CONFIG_SENSORS_XDPE122)	+= xdpe12284.o
>   obj-$(CONFIG_SENSORS_XDPE152)	+= xdpe152c4.o
>   obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
>   obj-$(CONFIG_SENSORS_PIM4328)	+= pim4328.o
> +obj-$(CONFIG_SENSORS_CRPS)	+= crps.o
> diff --git a/drivers/hwmon/pmbus/crps.c b/drivers/hwmon/pmbus/crps.c
> new file mode 100644
> index 000000000000..09425c404fc8
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/crps.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2024 IBM Corp.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/of.h>
> +#include <linux/pmbus.h>
> +
> +#include "pmbus.h"
> +
> +static const struct i2c_device_id crps_id[] = {
> +	{ "intel_crps185" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, crps_id);
> +
> +static struct pmbus_driver_info crps_info = {
> +	.pages = 1,
> +	/* PSU uses default linear data format. */
> +	.func[0] = PMBUS_HAVE_PIN | PMBUS_HAVE_IOUT |
> +		PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_IIN |
> +		PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT |
> +		PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +		PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
> +		PMBUS_HAVE_STATUS_TEMP |
> +		PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12,
> +};
> +
> +static int crps_probe(struct i2c_client *client)
> +{
> +	int rc;
> +	struct device *dev = &client->dev;
> +	char buf[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
> +
> +	rc = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> +	if (rc < 0) {
> +		dev_err_probe(dev, rc, "Failed to read PMBUS_MFR_MODEL\n");
> +		return rc;

		return dev_err_probe(...);

> +	}
> +
> +	if (strncmp(buf, "03NK260", 7) == 7) {

strncmp() never returns 7. You probably want something like

	if (rc != 7 || strncmp(buf, "03NK260", 7)) {

> +		buf[rc] = '\0';
> +		dev_err_probe(dev, -ENODEV, "Model '%s' not supported\n", buf);

		return dev_err_probe(...);

> +		return -ENODEV;
> +	}
> +
> +	rc = pmbus_do_probe(client, &crps_info);
> +	if (rc) {
> +		dev_err_probe(dev, rc, "Failed to probe %d\n", rc);

dev_err_probe() already handles the error, and a message such as
"failed to probe -22" isn't very useful anyway. Also,
		return dev_err_probe(...);

> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id crps_of_match[] = {
> +	{
> +		.compatible = "intel,crps185",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, crps_of_match);
> +
> +static struct i2c_driver crps_driver = {
> +	.driver = {
> +		.name = "crps",
> +		.of_match_table = crps_of_match,
> +	},
> +	.probe = crps_probe,
> +	.id_table = crps_id,
> +};
> +
> +module_i2c_driver(crps_driver);
> +
> +MODULE_AUTHOR("Ninad Palsule");
> +MODULE_DESCRIPTION("PMBus driver for Intel Common Redundant power supplies");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("PMBUS");


