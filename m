Return-Path: <linux-aspeed+bounces-257-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA33E7717F
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Dec 2024 18:48:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBpqS6vdJz2yhT;
	Tue, 17 Dec 2024 05:48:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734374900;
	cv=none; b=CBxNjG7OQQ+uSUNlBaSpQApndOQmeQJrKq6c5joQwBLmgLegxb0qC2YdUBkvFRF2miB0CEIMwaYLMEAaG1TdjyJevBJqxgiRX0vDVUSg3xDEcMDj6a/M8I1QvmuCCuZa8mv5oNzyZ8C19ue7nT6O7cPbHYxnT1znNzlTZpDhRI/M6hK16v0Aly0cYQXX1CKePGyKnmQjQCiKzXuUYzcponVdzzTxI16KqsX0tMUQ/1Ba3YGxpwHTL+6CqGaKfjj9BvKqBn07qOPhQ9zOrubis+7WPKOBV2p9GBCj4DskS//ZRWGJgwPQQzZbF2sITlSvENugQ6M7kNPpxVXsUJ4DEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734374900; c=relaxed/relaxed;
	bh=GUU/XypxaduzqMjt/wtaQMQLw5fmlBNHttBG958fM88=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OOiB+Bmsn/Xs/8rKCz1slXej8B3yG6F0cezc1mduX3CkO6by8FLrV0+Jc9Oq9XmOWKrb2gl6cyqsVFNoS3BTs7MwiEgoEZkRBM0vDAOvNbhyzAB/yPvKrd0HDow7Bd4TEI8UkhDQaOAoRAZ7Rlw5NiKgwajLxiCtFxvj7Qr3QZbsdGDxIxyZcYWOx6KIlCibjKcp8jlNbDOKijhhN03AeDqhzPYiqreZnLbHr84IqN9zSUO+XnsEuXSWGakpGrcLv8ja/gaMkMxa7D3GCIRkGfYvb+zHfTLGjjPncBaYiL52fSqcTOU8uCFmq8LC+DLuO3WuTWvKFMubI981r8FdlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ACDwokZn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ACDwokZn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBpqS0CGSz2xGH
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Dec 2024 05:48:19 +1100 (AEDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-801c7e6518eso1646106a12.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Dec 2024 10:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734374897; x=1734979697; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GUU/XypxaduzqMjt/wtaQMQLw5fmlBNHttBG958fM88=;
        b=ACDwokZnoR3UHLYgeVoOJ6/TQUFJ31H/XrZIhCIZL1Ob+G+EI3nLw+QlueyvqMYvzP
         2vaggR12hCzZbPhnLCjpvVi/Eb3v9IN3jj+l9YNilJPt//1/BA/tKCbSpifYFscvOXlD
         JEQqOSKM5z1YffRP9vC9OET05zADtEaxZJU+EdaXqnBRXiYysPoKCGTKsVJ+QjDoSjw+
         AIgl+SbDrhdRpjbTCmXYaHXVaEPEK3ChLLjChU4PUSBxATcuoc7vdzvrqN3frx8IoOBO
         +ylVdbLwgFPA0uZ5KUIppneNqrAPfF2xxiHxsGCajf+rtqh6ngz48YeXvu8UQSaXJmX3
         LD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734374897; x=1734979697;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUU/XypxaduzqMjt/wtaQMQLw5fmlBNHttBG958fM88=;
        b=BdaR5hBprWTY94V4uag6nYm2H6+frn88ywZzjudvtUyENmsadb62lrq8y4W3ETyOyW
         1RvNFYvUqbT2UIxw8R5IQvvu80RB6qQONxzgyslyUB+UYof6L+mPM/nH84+28VygDAlN
         sj/Jh2aUSEFJJBH0ME2i4Al8cwlj2FzqyZbEQfsO3Eb6fKHJMn0Uq99FUXTmMZgNmz+5
         Jye5QjUV8UUPv0eGTEVQHRh66warh4/esYkA8yQoq/CbcL8r3pnC/3ibdToixLQdoBWC
         Eyjov+STJKPNNPiwgE+Ow/t80u2Ygc+8d1nsSz+A+IzCyMi33U2H+IXEsAg3/3ZU1JmV
         Fr1g==
X-Forwarded-Encrypted: i=1; AJvYcCWSuV6OzDGxWMwwl4eCXCkFPZobjnuSx535PepzGu8NtOJqhdzWsMUp0CAuncSLxzX3VDUqTFud8fazH7o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz8d77VgpAaqREP4iWRyIxO9Wt6BkTe1g0up9JxlWk5Vu6o/eB7
	p3809x1U0B2GbYa8KBoovCc9sLg/+6JI+XZf5Xn5oqp3Gx7LpMD6
X-Gm-Gg: ASbGncu+ZR81xCiIfbg0mZrOnhKji5N63u1BS81qKe8gdBlcNLjs3C1w8Y2QB+9NEw1
	wFST4pCCuhXvjDud0+ZK4a9Uz4G6oN9AniWhQxnlow7NItbKjdPkvgA/llW8mz0YxwPfHeoNGNN
	Hv+U7kkXEAY1olh/xpdbU+YTBP9VTnj4fmKtGw6fkq/C3Ppj110F8Na5MvA3eviQxcM2+fX5RZh
	NX9nspmR6uK8rhxJCc8R54DQyLoCctCfcHj0G2in9IS3RpcjDTbRRPbhOkhfA/gMeY53t+rq1YE
	lbMeAjO9kIT5NlVzu59SPEGqpUeJMA==
X-Google-Smtp-Source: AGHT+IFjQgGzXMt3UDx2US4yIi+IDTITId8IwO9BLtbyFBWANvRg/nW81MMDSaOHXQlVmHcHYluZ1w==
X-Received: by 2002:a17:90b:2e4f:b0:2ee:f687:6ad5 with SMTP id 98e67ed59e1d1-2f2d7d6d692mr891327a91.2.1734374897329;
        Mon, 16 Dec 2024 10:48:17 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142c2b1f6sm8453029a91.0.2024.12.16.10.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 10:48:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c64bb634-46d4-486a-8743-699775326058@roeck-us.net>
Date: Mon, 16 Dec 2024 10:48:14 -0800
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
Subject: Re: [PATCH v2 0/4] Add support for Intel CRPS PSU
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241216175044.4144442-1-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 09:50, Ninad Palsule wrote:
> Hello,
> 
> Please review the patchset for Intel CRPS185 driver.
> V2:
> ---
>    - Incorporated review comments by Guenter Roeck
>    - Incorporated review comments by Krzysztof Kozlowski
> 

That is not a useful change log. Please describe what you changed, not who
asked for it.

Guenter

> Ninad Palsule (4):
>    hwmon: (pmbus/core) Add PMBUS_REVISION in debugfs
>    hwmon: (pmbus/crps) Add Intel CRPS185 power supply
>    dt-bindings: hwmon: intel,crps185: Add to trivial
>    ARM: dts: aspeed: system1: Use crps PSU driver
> 
>   .../devicetree/bindings/trivial-devices.yaml  |  2 +
>   Documentation/hwmon/crps.rst                  | 97 +++++++++++++++++++
>   Documentation/hwmon/index.rst                 |  1 +
>   MAINTAINERS                                   |  7 ++
>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     |  8 +-
>   drivers/hwmon/pmbus/Kconfig                   |  9 ++
>   drivers/hwmon/pmbus/Makefile                  |  1 +
>   drivers/hwmon/pmbus/crps.c                    | 79 +++++++++++++++
>   drivers/hwmon/pmbus/pmbus_core.c              | 13 ++-
>   9 files changed, 211 insertions(+), 6 deletions(-)
>   create mode 100644 Documentation/hwmon/crps.rst
>   create mode 100644 drivers/hwmon/pmbus/crps.c
> 


