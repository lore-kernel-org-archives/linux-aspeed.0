Return-Path: <linux-aspeed+bounces-212-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650ABE7717F
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 22:06:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8RPn0Mv8z30Wm;
	Fri, 13 Dec 2024 09:06:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734041180;
	cv=none; b=Se8GUqMspu0j85YrkzpFK8Xeqp9kfG9T215bOOofX2ousHZmONN00jkJJib3xnHGQHP6vFJ/aRHDrCgNzaylt1+j+FmZYQhcqEgqxViLZ66ZhYeNgJ72OsmpRciQ43nLZmYVnQ1DH0RCj7JcUpgozlcjBACXBTdlqCSy+tYNpqohj8Cf21AK45Y8DKiAN8++cAAGWxQfsTXSyM1RBsX31IrHmzyX2kB48ZyhgYsx5DCzXlxzJ+RYs0vsAN2cgQ5gQyGSFxcpChyTu7XW16PZXmPW20grKvA0t8e1vpwaJjcOGSl+L54PknRLi1JUDNgDppV8z7fWv0P/x7oyMOoAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734041180; c=relaxed/relaxed;
	bh=Nn7aTGxs0fZIZsteSxxOdiaizy01Z8EgP8KAplxUb/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tat+iHhHQCaWSwke5xbpR94/W+LK6D80YsbUuWZSi3fG9mt/RVdk6XhfA6TCrncnCv5g/9xnFIv0I4BYuBkcAxBCCjHPh8fOZO6v0IGha6FpXu64tpm4Kwc1UaueXoW3KqSMLPyvSmoJgpclw/DYLW1/86xfyI415UYy47Cuy1End3SaIOs2NMGMDpJ0YGU/B04WGM7IYLxarm1j/j0WQlbpw0yOU8DgW+r4A7K/wHUi/nGec6nLZhlRXMNk9zjnGHyCFrgVmhu+OJwOsjM3IaFO+uuNiWLSfvBO07ryQ/vIxU/oTMy1+u7sErF5B8fSUCwYit13Ubl2LD8F7xj/yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=L2W5udFf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=L2W5udFf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8RPk4Zhcz2yDt
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 09:06:17 +1100 (AEDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-7fd4c0220bbso1107609a12.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Dec 2024 14:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734041173; x=1734645973; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Nn7aTGxs0fZIZsteSxxOdiaizy01Z8EgP8KAplxUb/s=;
        b=L2W5udFfm8BRk9W3z2zzButDm9BaGepfBt1w0k+ojBg9yrfTsWWAS20OOej9ax14qT
         zMExUSaG+dx/Z1By3it7k65Wd+tlAKG6LS9PxOzkvq4zmaVM5K8bWn+mZWqUFX+Pps+7
         3KbA46OXKlFRIoRUdq5m9u9T24eKw5tZrfkI3cG4aqpm44XBcO6gg7KLew4GHUh4zAQn
         FDbxFo6JRj0IyvJBwvEtUgyQDpVb1XPEXCyZJV0SmnpdstfxTIfdOzbLlLUcbhphMbg4
         ZaYBsldSVV+zttB2lNA/MAencz0nL1SKy3Y6wiCjMvxbcGKlF7wuc8csyuIEacNxiPyk
         TmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734041173; x=1734645973;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn7aTGxs0fZIZsteSxxOdiaizy01Z8EgP8KAplxUb/s=;
        b=tjKe4lYXcF94t/sUySiByG45Zjao74x3w/Bs5S85PV4GZrsbUrBJWSP8awq5BfLcct
         KGWlnvdR9ywGxZnwbMP9ALYXwAjVQlkORI1mekL2i8hTSHIem3sNcKZ0LTbRYD4mPEWR
         RXa9eWNgPPVr5fnHoko5MtEAka8KpQ+Ax+Ykq4IzGAKQjvFDoge5uCboGvV+TVZxH4IO
         ONN/a5SizhoNSjlKRREyDmaCiDHs2N5Puf7n9lKN4kD3DV4pFk5zSF3lzMj2ssbJqcON
         dXQVc1p+VY5XnJ7WaI9P16Q1avlnX4bYplH9DwDGKzNDPNMf8yq0akMc8lCQozQdcp98
         tYQg==
X-Forwarded-Encrypted: i=1; AJvYcCXq9iH8jgL9JZliIVf5UE9L9x6jlJm0vxOHWnvuJlGULCRXIw82696ZUH7xxBIhW1GQumd5QhLcoswQOQY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzbnGzgSr5er6N/U3CpHMr+VYt+3ucpjFT9UF5uyk1sMcPXHV94
	6ZE52IjTQhWsehiucJxSRIGUK1iapQH9TN9HZouB+oMpVRnV4LKG
X-Gm-Gg: ASbGncsWAMebe2hruPI/T2n1Ku/H00YkUXzn2Fj5m1AfUDzZHr8lq/EDOP/x5UYD+js
	gSt9DEEbJaMr07oss+JpSrNEZ10nnJz3rgzmMn4xtL4L5R1Nwl7H9+f9mNwODje14kZgIGX+F1N
	dMSc+QN7RcUe1gd/H5JEvLCucQm/jPQZGVpGWKxTrzI2RDhn8dFu5xrgK3WEvRVSh7r3IlRPREb
	0FIHjxpFpiZDm2zeWOtV34Y1EeUdEGEIa5rXHLNK48+eI7H4aaG+3R2V6eTidmEyQDEeaysKIQR
	2yVp3OSwPWJGR9h+1vV2G4l/ubiVYQ==
X-Google-Smtp-Source: AGHT+IEjcDWDcj+xx58FwEzylYzqnHeRBxwumiFyM7ZjcMUkstRS8dJbxY3ZD6142f7rcv8umWohsA==
X-Received: by 2002:a17:90b:2682:b0:2ea:7cd5:4ad6 with SMTP id 98e67ed59e1d1-2f2901b3181mr476376a91.32.1734041172844;
        Thu, 12 Dec 2024 14:06:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142de7ddfsm1799771a91.26.2024.12.12.14.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 14:06:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f9d881b7-7301-476e-b281-0380dfcf0e10@roeck-us.net>
Date: Thu, 12 Dec 2024 14:06:09 -0800
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
Subject: Re: [PATCH v1 1/4] hwmon: pmbus-core: Add label for fan and temp
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
References: <20241212214927.3586509-1-ninad@linux.ibm.com>
 <20241212214927.3586509-2-ninad@linux.ibm.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241212214927.3586509-2-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 13:49, Ninad Palsule wrote:
> Adding label files for fan and temperature sensors in the power supply.
> The openbmc application dbus-sensor(psusensor) requires those files to
> consfigure those sensors.
> Note that prefix for temp label is temp[A..C] used instead of temp[1..3]
> as dbus-sensor(psusensor) application calculate index based on last
> digit in the name so we do not want to make index double digit after
> appending page index.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>

We are not going to fix userspace problems in the kernel.

Guenter

> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index a7000314e5ad..149b3c5f3a4c 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2144,6 +2144,7 @@ static const struct pmbus_sensor_attr temp_attributes[] = {
>   	{
>   		.reg = PMBUS_READ_TEMPERATURE_1,
>   		.class = PSC_TEMPERATURE,
> +		.label = "tempA",
>   		.paged = true,
>   		.update = true,
>   		.compare = true,
> @@ -2156,6 +2157,7 @@ static const struct pmbus_sensor_attr temp_attributes[] = {
>   	}, {
>   		.reg = PMBUS_READ_TEMPERATURE_2,
>   		.class = PSC_TEMPERATURE,
> +		.label = "tempB",
>   		.paged = true,
>   		.update = true,
>   		.compare = true,
> @@ -2168,6 +2170,7 @@ static const struct pmbus_sensor_attr temp_attributes[] = {
>   	}, {
>   		.reg = PMBUS_READ_TEMPERATURE_3,
>   		.class = PSC_TEMPERATURE,
> +		.label = "tempC",
>   		.paged = true,
>   		.update = true,
>   		.compare = true,
> @@ -2282,6 +2285,17 @@ static int pmbus_add_fan_attributes(struct i2c_client *client,
>   					     PSC_FAN, true, true, true) == NULL)
>   				return -ENOMEM;
>   
> +			/*
> +			 * Add fan label.
> +			 * Assuming paged attributes while passing page index
> +			 */
> +			ret = pmbus_add_label(data, "fan", index, "fan",
> +					      page + 1, 0xff);
> +			if (ret) {
> +				dev_err(data->dev, "Fan label add failed ret=%d\n", ret);
> +				return ret;
> +			}
> +
>   			/* Fan control */
>   			if (pmbus_check_word_register(client, page,
>   					pmbus_fan_command_registers[f])) {


