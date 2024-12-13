Return-Path: <linux-aspeed+bounces-213-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49552E7717F
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Dec 2024 01:30:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8Wwr4Qptz30Sy;
	Fri, 13 Dec 2024 12:30:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734053404;
	cv=none; b=mePUEQjqgc0XDbUB0tt6rnqsoEzYsNmnZBGWd55u8wh4Lat/a+o3zjtelZc7+asAJqOatllNUbP3Tb74AOlerpos52cA6h/3vfAMogZIGifXtG70zS07lyXS59cMAA36WIGOO+4DLkn67ixb4D930ueZPNWZ9YesI3LzIIZdnXbq5fW+dzeZe9HjUKEh2gzb0d/x2opH3jy3vVRsEeue8Lg/kgbF4PL6Zp2Kx1019oibs7hV4HJOM65NztKd+V+ztkWuIpOkL/Ao6TG/hYDnOMId0GogHIQUwLKSEUspM5inlb8ugYUdMbAcnqmbchmAni5paEjlEnjwN1U+2EosWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734053404; c=relaxed/relaxed;
	bh=UHxuky/SCPbxlr/K9QZgjbJ2leIhHL7DLNdsBhTbdC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Utxzazga39n1lSBxbGetEj3PDqTKRs0XApHVKE7tClghUqp0lztwS8UipNocrvxYVKs9kVQp7Ww2Aks50tdKNw4guz6U4ocW1E97Fx9JWPYdDDO1OAqjNVy1pNDJPlUu3FlxrGn3ICRdsw9EVqQAy0A8TBrey2+mGzcdPPFhnCTu7SAHgY92FaPn1dKLCe0gmQ9+o/o1dlyP5Du8rZok5bW3vPT3UF/bobXOAwIlDoUu4j1zTUXND409/Ld5GWZARt9kCxCksHSvgqzcrNqnIxkQsHdrlLAsXxyxlrp/QMU4p178n7p70YgPWuptfvs8u1+NxQcGIaSUMovMbM7sVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aEdXOtEd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aEdXOtEd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8Wwn6tchz2yXm
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 12:30:00 +1100 (AEDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-725e71a11f7so1909996b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Dec 2024 17:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734053395; x=1734658195; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UHxuky/SCPbxlr/K9QZgjbJ2leIhHL7DLNdsBhTbdC4=;
        b=aEdXOtEdSg8J5m6TrKiB44tzIYtUZZaWEGUxsW507aWvHBW8fX42oqHtYX6x2+nT0u
         kwkLVFE7pt2G6Gzw4TFaWI9GzB7cZo3a01PtHtX8F9+UVJjk5uSUMoV4NumVMtHmVX8s
         wnEpxJS5yUHQbfHzkGa+PUe33/LW2DTvwAzDR0HX+JM+2ksEmxib7XTu9NrOzgQMpqS7
         E233oE8g6t/XZn0AfRzKNuJNnr2SiJ7wm9v5ABY50Nkd69O2l/H1oMLKYKFx4u3Vlu3A
         ap1hRg1S6YrGX1N7mfS0bNUv9aJCA34vTxzcV3hNb0qHDA74jUu+jcNLAZGJ5HxvVlHh
         9zPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734053395; x=1734658195;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHxuky/SCPbxlr/K9QZgjbJ2leIhHL7DLNdsBhTbdC4=;
        b=S9AU/ceMcgjqslecZ6/+mVXUh4z8BegMeOjBUAnHqjHVkkEL428PbRofIVdR5D0m1x
         oJIIk5jT0c+2esm0F67EXg5PNTgvFDWvfCORCOGRSVWmWoAqyXA2pSmjagJUNpn3jVRH
         CUCEYF6yHdG9NBpTa0TRMypzRzV6q4aBGjDAVe3ql9FRnrLGZ9cM/WhOqfS/gGj8FIA7
         zsDWw1Wve1nbw6LNrzRbviW+nUBISvSWBZo3zu5bQf5kTV9t7LOWCKENkNRpg7Pseey3
         Sw1tmfLX4EYItC12WxFAErQd2ELq4HFborhjjurJwrn9kELjStlNFdcC3q1eEelCBwp9
         3CXw==
X-Forwarded-Encrypted: i=1; AJvYcCXDvlbeTil8duHxDIQPpLbDfEa4T4nmNhv8GDeoSTRMl4IKsITkOnB3mUrvEmHcv/kdKSHCUQ30d+4F0dc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwoY0OSSpv/wzBxVlHEqVeRRj3wc8956q+RzmqtaQPY0FP22Dm8
	LHU49OM1oEkqVrq9UK5QXF0xaiWbH5yhi3R/fruynpYmMEuZz+1I
X-Gm-Gg: ASbGnctx4Sa0C8701e71UobdlIsbZerN+Jfrep7Z7yeAcjTEh7xQnZcrTpD7NTJtzlX
	SjOHlDycwTVrDzClfQ90x4ylIUcSdsBdRcArcbHVlanT9pwVCmebu8g9K9v5UFX/hZ+cTmExKfd
	yqOpu2dZL8g4Mv9PLqiF38p7/85MB8lJQTyrOpHspjo0gpiURNZCnzEPMFhbOsgylYKVkWCe8+G
	w39iRbBJNWvL3nqHM25oyReLPl24NcJ+RL4h8Q2bb12r2yZcQC2faTXwHE7SobJwKM1SqEucSwS
	nEl8Mu61c6b0spijId705xedbvZ1gg==
X-Google-Smtp-Source: AGHT+IGI4Ve+ApM2wGnjbhyWZAaIqje+11k7lRzjKGuZqrFJsTvt87E9pQe6xCjoZiGAairhYxSjJw==
X-Received: by 2002:a05:6a20:9f04:b0:1e1:a449:ff71 with SMTP id adf61e73a8af0-1e1dff86960mr1031915637.1.1734053395225;
        Thu, 12 Dec 2024 17:29:55 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7261829be9dsm7146387b3a.89.2024.12.12.17.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 17:29:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5b095371-f835-4c23-aa43-deefa33123bb@roeck-us.net>
Date: Thu, 12 Dec 2024 17:29:51 -0800
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
Subject: Re: [PATCH v1 2/4] hwmon: (pmbus/crps) Add Intel CRPS185 power supply
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
 <20241212214927.3586509-3-ninad@linux.ibm.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241212214927.3586509-3-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 13:49, Ninad Palsule wrote:
> Add the driver to monitor Intel common redundant power supply (crps185)
> with hwmon over pmbus.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   Documentation/hwmon/crps.rst |  95 +++++++++++

Documentation/hwmon/index.rst needs to be updated.

>   MAINTAINERS                  |   7 +
>   drivers/hwmon/pmbus/Kconfig  |   9 ++
>   drivers/hwmon/pmbus/Makefile |   1 +
>   drivers/hwmon/pmbus/crps.c   | 299 +++++++++++++++++++++++++++++++++++
>   5 files changed, 411 insertions(+)
>   create mode 100644 Documentation/hwmon/crps.rst
>   create mode 100644 drivers/hwmon/pmbus/crps.c
> 
> diff --git a/Documentation/hwmon/crps.rst b/Documentation/hwmon/crps.rst
> new file mode 100644
> index 000000000000..81d5dfd68a46
> --- /dev/null
> +++ b/Documentation/hwmon/crps.rst
> @@ -0,0 +1,95 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver crps
> +========================

I am quite sure that this triggers a documentation warning.

> +
> +Supported chips:
> +
> +  * Intel CRPS185
> +
> +    Prefix: 'crps185'
> +
> +    Addresses scanned: -
> +
> +Authors:
> +    Ninad Palsule <ninad@linux.ibm.com>
> +
> +

Is the documentation available somewhere ?
If yes, please add a reference. If not, add a comment explaining that
it is not available to the public.

> +Description
> +-----------
> +
> +This driver implements support for Common Redundant Power supply with PMBus

For _Intel_ ...

> +support.
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
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 637ddd44245f..6b31d545f0f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6100,6 +6100,13 @@ L:	linux-input@vger.kernel.org
>   S:	Maintained
>   F:	drivers/hid/hid-creative-sb0540.c
>   
> +CRPS COMMON REDUNDANT PSU DRIVER

This is _INTEL_ CRPS.

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
> index 22418a05ced0..56c4eb4b846e 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -85,6 +85,15 @@ config SENSORS_BPA_RS600
>   	  This driver can also be built as a module. If so, the module will
>   	  be called bpa-rs600.
>   
> +config SENSORS_CRPS
> +	tristate "Common Redundant Power Supply"

Again, this is an Intel product.

> +	help
> +	  If you say yes here you get hardware monitoring support for the Common
> +	  Redundant Power Supply.
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
> index 000000000000..44d309f81803
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/crps.c
> @@ -0,0 +1,299 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2024 IBM Corp.
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/i2c.h>
> +#include <linux/of.h>
> +#include <linux/pmbus.h>
> +
> +#include "pmbus.h"
> +
> +/* Intel crps185 specific commands. */
> +#define CRPS185_MFR_IOUT_MAX		0xA6
> +#define CRPS185_MFR_POUT_MAX		0xA7
> +

I fail to see the point in those defines, even more so since
PMBUS_MFR_POUT_MAX and PMBUS_MFR_IOUT_MAX are used below.

> +enum {
> +	CRPS_DEBUGFS_PMBUS_REVISION = 0,
> +	CRPS_DEBUGFS_MAX_POWER_OUT,
> +	CRPS_DEBUGFS_MAX_CURRENT_OUT,
> +	CRPS_DEBUGFS_NUM_ENTRIES
> +};
> +
> +enum models { crps185 = 1, crps_unknown };

Pointless enum. The driver only supports a single power supply.

> +
> +struct crps {
> +	enum models version;
> +	struct i2c_client *client;
> +
> +	int debugfs_entries[CRPS_DEBUGFS_NUM_ENTRIES];
> +};
> +
> +#define to_psu(x, y) container_of((x), struct crps, debugfs_entries[(y)])
> +
> +static struct pmbus_platform_data crps_pdata = {
> +	.flags = PMBUS_SKIP_STATUS_CHECK,
> +};

Did you confirm that it is needed ? If so, explain why it is needed.

> +
> +static const struct i2c_device_id crps_id[] = {
> +	{ "intel_crps185", crps185 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, crps_id);
> +
> +/*
> + * Convert linear format word to machine format. 11 LSB side bits are two's
> + * complement integer mantissa and 5 MSB side bits are two's complement
> + * exponent
> + */
> +static int crps_convert_linear(int rc)
> +{
> +	s16 exponent;
> +	s32 mantissa;
> +	s64 val;
> +
> +	exponent = ((s16)rc) >> 11;
> +	mantissa = ((s16)((rc & 0x7ff) << 5)) >> 5;
> +
> +	val = mantissa;
> +	if (exponent >= 0)
> +		val <<= exponent;
> +	else
> +		val >>= -exponent;
> +
> +	return (int)val;
> +}
> +
> +static ssize_t crps_debugfs_read(struct file *file, char __user *buf,
> +				 size_t count, loff_t *ppos)
> +{
> +	int rc;
> +	int *idxp = file->private_data;
> +	int idx = *idxp;
> +	struct crps *psu = to_psu(idxp, idx);
> +	char data[2 * I2C_SMBUS_BLOCK_MAX] = { 0 };
> +
> +	rc = pmbus_lock_interruptible(psu->client);
> +	if (rc)
> +		return rc;
> +
> +	rc = pmbus_set_page(psu->client, 0, 0xff);
> +	if (rc)
> +		goto unlock;
> +
> +	switch (idx) {
> +	case CRPS_DEBUGFS_PMBUS_REVISION:
> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_REVISION);
> +		if (rc >= 0) {
> +			if (psu->version == crps185) {
> +				if (rc == 0)
> +					rc = sprintf(data, "%s", "1.0");
> +				else if (rc == 0x11)
> +					rc = sprintf(data, "%s", "1.1");
> +				else if (rc == 0x22)
> +					rc = sprintf(data, "%s", "1.2");
> +				else
> +					rc = snprintf(data, 3, "0x%02x", rc);
> +			} else {
> +				rc = snprintf(data, 3, "%02x", rc);
> +			}
> +		}

This attribute should be added into the PMBus core.

> +		break;
> +	case CRPS_DEBUGFS_MAX_POWER_OUT:
> +		rc = i2c_smbus_read_word_data(psu->client, PMBUS_MFR_POUT_MAX);
> +		if (rc >= 0) {
> +			rc = crps_convert_linear(rc);
> +			rc = snprintf(data, I2C_SMBUS_BLOCK_MAX, "%d", rc);
> +		}
> +		break;
> +	case CRPS_DEBUGFS_MAX_CURRENT_OUT:
> +		rc = i2c_smbus_read_word_data(psu->client, PMBUS_MFR_IOUT_MAX);
> +		if (rc >= 0) {
> +			rc = crps_convert_linear(rc);
> +			rc = snprintf(data, I2C_SMBUS_BLOCK_MAX, "%d", rc);
> +		}
> +		break;

What is the point of those two attributes ? There are already
standard sysfs attributes reporting those values.

> +	default:
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +unlock:
> +	pmbus_unlock(psu->client);
> +	if (rc < 0)
> +		return rc;
> +
> +	data[rc] = '\n';
> +	rc += 2;
> +
> +	return simple_read_from_buffer(buf, count, ppos, data, rc);
> +}
> +
> +static const struct file_operations crps_debugfs_fops = {
> +	.llseek = noop_llseek,
> +	.read = crps_debugfs_read,
> +	.open = simple_open,
> +};
> +
> +static int crps_read_word_data(struct i2c_client *client, int page,
> +				int phase, int reg)
> +{
> +	int rc;
> +
> +	switch (reg) {
> +	case PMBUS_STATUS_WORD:
> +		rc = pmbus_read_word_data(client, page, phase, reg);
> +		if (rc < 0)
> +			return rc;
> +		break;

Why is this needed ?

> +	case PMBUS_OT_WARN_LIMIT:
> +		rc = pmbus_read_word_data(client, page, phase,
> +					  PMBUS_MFR_MAX_TEMP_1);
> +		if (rc < 0)
> +			return rc;
> +		break;
> +	case PMBUS_IOUT_OC_WARN_LIMIT:
> +		rc = pmbus_read_word_data(client, page, phase,
> +					  CRPS185_MFR_IOUT_MAX);
> +		if (rc < 0)
> +			return rc;
> +		break;
> +	case PMBUS_POUT_OP_WARN_LIMIT:
> +		rc = pmbus_read_word_data(client, page, phase,
> +					  CRPS185_MFR_POUT_MAX);
> +		if (rc < 0)
> +			return rc;
> +		break;

The above three values are more than odd. They duplicate the respective
standard rated_max attributes as warning limits. Why ?

On top of that, on writes, the actual warning limits are overwritten.
That makes even less sense.

> +	default:
> +		rc = -ENODATA;
> +		break;
> +	}
> +
> +	return rc;
> +}
> +
> +static struct pmbus_driver_info crps_info[] = {
> +	[crps185] = {
> +		.pages = 1,
> +		/* PSU uses default linear data format. */
> +		.func[0] = PMBUS_HAVE_PIN | PMBUS_HAVE_IOUT |
> +			PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_IIN |
> +			PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT |
> +			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +			PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
> +			PMBUS_HAVE_STATUS_TEMP |
> +			PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12,
> +		.read_word_data = crps_read_word_data,
> +	},
> +};
> +
> +#define to_psu(x, y) container_of((x), struct crps, debugfs_entries[(y)])
> +
> +static void crps_init_debugfs(struct crps *psu)
> +{
> +	struct i2c_client *client = psu->client;
> +	struct dentry *debugfs;
> +	int i;
> +
> +	/* Don't fail the probe if we can't create debugfs */
> +	debugfs = pmbus_get_debugfs_dir(client);
> +	if (!debugfs)
> +		return;
> +
> +	for (i = 0; i < CRPS_DEBUGFS_NUM_ENTRIES; ++i)
> +		psu->debugfs_entries[i] = i;
> +
> +	debugfs_create_file("pmbus_revision", 0444, debugfs,
> +			    &psu->debugfs_entries[CRPS_DEBUGFS_PMBUS_REVISION],
> +			    &crps_debugfs_fops);
> +	debugfs_create_file("max_power_out", 0444, debugfs,
> +			    &psu->debugfs_entries[CRPS_DEBUGFS_MAX_POWER_OUT],
> +			    &crps_debugfs_fops);
> +	debugfs_create_file("max_current_out", 0444, debugfs,
> +			    &psu->debugfs_entries[CRPS_DEBUGFS_MAX_CURRENT_OUT],
> +			    &crps_debugfs_fops);
> +}
> +
> +static int crps_probe(struct i2c_client *client)
> +{
> +	int rc;
> +	struct device *dev = &client->dev;
> +	enum models vs = crps_unknown;
> +	struct crps *psu;
> +	const void *md = of_device_get_match_data(&client->dev);
> +	const struct i2c_device_id *id = NULL;
> +	char buf[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
> +
> +	if (md) {
> +		vs = (uintptr_t)md;
> +	} else {
> +		id = i2c_match_id(crps_id, client);
> +		if (id)
> +			vs = (enum models)id->driver_data;
> +	}
> +
Consider using i2c_get_match_data().

> +	if (!vs || vs >= crps_unknown) {
> +		dev_err(dev, "Version %d not supported\n", vs);
> +		return -EINVAL;
> +	}

This is very much pointless. The driver would not be instantiated withut match.

> +
> +	rc = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> +	if (rc < 0) {
> +		dev_err(dev, "Failed to read PMBUS_MFR_MODEL\n");
> +		return rc;

dev_err_probe().

> +	}
> +	if (strncmp(buf, "03NK260", 7)) {

This should also check and ensure that rc == 7.

> +		buf[rc] = '\0';
> +		dev_err(dev, "Model '%s' not supported\n", buf);

dev_err_probe()

> +		return -ENODEV;
> +	}
> +
> +	client->dev.platform_data = &crps_pdata;
> +	rc = pmbus_do_probe(client, &crps_info[vs]);
> +	if (rc) {
> +		dev_err(dev, "Failed to probe %d\n", rc);
> +		return rc;

dev_err_probe().

> +	}
> +
> +	/*
> +	 * Don't fail the probe if there isn't enough memory for debugfs.
> +	 */
> +	psu = devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
> +	if (!psu) {
> +		dev_warn(dev, "Failed to allocate memory. debugfs are not supported.\n");
> +		return 0;
> +	}
> +
> +	psu->version = vs;
> +	psu->client = client;
> +

Drop all this. Add the PMBus version as standard debugfs attribute to the PMBus core
if needed/wanted. The rest is already provided as standard sysfs attributes, and
reporting the same value in debugfs files adds no value.

> +	crps_init_debugfs(psu);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id crps_of_match[] = {
> +	{
> +		.compatible = "intel,crps185",
> +		.data = (void *)crps185
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
> +MODULE_DESCRIPTION("PMBus driver for Common Redundant power supplies");

Again, this is for _Intel_ power supplies.

> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("PMBUS");


