Return-Path: <linux-aspeed+bounces-1546-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361DCC77B7C
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Jun 2025 07:29:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bRGmJ6BTMz2yft;
	Tue, 24 Jun 2025 17:29:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750750160;
	cv=none; b=kUzf3bkVRaig9Vhpg+OjIyNxN17yygbkURALOQws20iBNNmplrHgG9ixIWb9bCReXT77+jKwBFCuVrpLR7GEl1vVaXemreFiLVPUtao13o8J3ODy3bvhnc/XGW+njRQ2yEGuUZdB1VjcolDafdSW0CDoRW4ttN9wbNdos42GsJ921oRl4T1lhkhlV9CrcusCG1PXCSYodnC1idt8e7BlwnUC/9Ejvhk8JlG0LFbI3THH6eNpHlUYX6Bt62HhHlo4+0l5BY8bFlcvbqjzs2MdFrmD90YYN2zBufCFpzC7MYUzgLDBtyozA8N8fl8mDAdircIT3O3dT7gQqWWOl92shA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750750160; c=relaxed/relaxed;
	bh=vXQvyWKGqoA++0+nLyhrIs47IOqxWVGOvjV4paCklaM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=J6JsXcc86iEj2c1ckSFZXvYfoYt/vEv5Le0CYHS1sK/rM9Qr/Xcf0ND4DN5JGEBFafO6MsnXgAneF47QkrBMhy1Bczn2SsDfDZjNSi50uFUXXdCSQYAQso1O2CDcv81qkyQ4gLqcWckNPWVb2GvlLm6kP5jXRkXjwTm3cpBNwivsocSaDVm75IJnTM0SXy0vGgj+jX5ZiY08xfsydhFFSq3hOrWW6YJ0DmntN/Ggnbx7WB2m98WGB0Vx4TNR08URpcJO+fv9N6fak75V50Ofi4JjX2rSHkmLlSN4a/AdIYBUCpTkahHFKb+hD0TL3Uejm8c/V9/9pjTG8yy9RHtPBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jRxauPZ6; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=neil.armstrong@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jRxauPZ6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=neil.armstrong@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRGmH10K9z2xHT
	for <linux-aspeed@lists.ozlabs.org>; Tue, 24 Jun 2025 17:29:18 +1000 (AEST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-453647147c6so909385e9.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 24 Jun 2025 00:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750750153; x=1751354953; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXQvyWKGqoA++0+nLyhrIs47IOqxWVGOvjV4paCklaM=;
        b=jRxauPZ6nSuxKSzZPfOVn/7/NkiWyo4+scsZakiZHs1cqxdQITgM7gbr1e8OHNa+Oo
         Ralb2dk2dS2xlaXi36oFAUHrDWXE14oqnmnbpPmILCQK1um06FqOHav+vwNJyo4jDINz
         mcOAALquLQ6wBOF+15nzHIhD5a9zQwWfZLenuqlzgC099fNvRt2R1PmxduADeJUcIrPB
         61rySKBWfgydAJUYm6nd6DnP5p2PrJkDJxwyUtKroJJ3dnvBb6ZcQqa3RgBV+scdAUoq
         KM7+jE1oKRhGKB7GjN7O4s7hNSRstd3qjpskmExtmCWWOJIAki6pfNzRef9nzDIVPHRb
         eLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750750153; x=1751354953;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vXQvyWKGqoA++0+nLyhrIs47IOqxWVGOvjV4paCklaM=;
        b=jXXMbAwFP9mndzjN8lAV1QuhV4Xos4jI4jgw4vw2OS+D0L4Y7hMbA8c6dxGrFVT6UX
         oZhP78lCuuyPFuV/em+puFolkvOFrPBW0XG07NouFRV4rz/3Roh9q2Yy2uj8ZcQYYbKb
         +vGvgSkOxKO6rpJKFZ0kZJKqey/HIEgvd6CM9EBjJJgUA7Qewcy31tOBlJ3cccnznlm1
         C/0dQ4s8lY9ftQEx5iyd0o4Ns21CrgbfTdZh7dAlVkdTjTOCdnalhx/B4zlhSByZX570
         36AIbdro5mipCkA5VPkDkSZRZpdxCFBdLzex/tDwOjeqEid9WN50uF4kSaBSKVz3KvLo
         nFiA==
X-Forwarded-Encrypted: i=1; AJvYcCXdb6VMgbME4VhaUQ130zxjgaxVIgLIBHjaT6pS9mfm6xPS9mOaQ9LmsTJAuwtMffKJJg/WzJ2/t3JIBKc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyWDm3W8p4Eqc79HtPm/KRtFKxhXihM/5DtxH2xTnyrS+nT21Z0
	+4tLthVMUfYYnYtF2vGVqZ3DVPU0aaWTi8reu62DjXVDCfWte7PXlX9rXmDzY6nSbo4=
X-Gm-Gg: ASbGncsPv4BhcePlDmCWhgfhe+EvmNnXHzffDkjZq2iaTF77zvDAkReJ9VIdMpUIZfe
	eYQjWhUs4LyK/7flnyAEAVqcx21GmNXZEztjQ0NY4ZdTTt6hdZT7A1KzkPM4x27OYVRyR/M/QUM
	D7ZQ3o5CDX9wSbm16n7ZgBk0NAkMQnQG1t8Uf04vLrv7dmGPsSqNDdAqZ69a8dCOMphaiIXStzS
	Wusw+N+vZQJUamp134RoDdJh+ACCGabaokfNwv0sa89cH93FSJA1Cz21PaqhpLO7WdKV79ZXFJY
	tr3Z+YWw/C19czqky5ioPa0kf4z9A9Z+x1jFDV7oziatQT3wv45P7nfdR855H0wwgiH8fgLOe3h
	ToeCvoksKEt2QvXfBZ8FQ6Q3Nt+jIyQU2w9XB+yg=
X-Google-Smtp-Source: AGHT+IFNAvVc0Ym/Nl4SzjssDYkzNoxmE/MYxf9idIfGl+W01JZ50berxeUOTRJ/Uec/VhLDWdvcjg==
X-Received: by 2002:a5d:64e6:0:b0:3a5:8d0b:600c with SMTP id ffacd0b85a97d-3a6d12bb37emr13160349f8f.3.1750750152898;
        Tue, 24 Jun 2025 00:29:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:6fea:600c:ca20:f54a? ([2a01:e0a:3d9:2080:6fea:600c:ca20:f54a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f27besm1190928f8f.57.2025.06.24.00.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 00:29:12 -0700 (PDT)
Message-ID: <754d260c-1a31-494e-af06-49f6aae1813f@linaro.org>
Date: Tue, 24 Jun 2025 09:29:11 +0200
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
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: =?UTF-8?B?UmU6IOWbnuimhjogW1BBVENIIDAvN10gQWRkIEFTUEVFRCBQQ0llIFJv?=
 =?UTF-8?Q?ot_Complex_support?=
To: Jacky Chou <jacky_chou@aspeedtech.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
 <joel@jms.id.au>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "vkoul@kernel.org" <vkoul@kernel.org>,
 "kishon@kernel.org" <kishon@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
 "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Cc: "elbadrym@google.com" <elbadrym@google.com>,
 "romlem@google.com" <romlem@google.com>,
 "anhphan@google.com" <anhphan@google.com>, "wak@google.com"
 <wak@google.com>, "yuxiaozhang@google.com" <yuxiaozhang@google.com>,
 BMC-SW <BMC-SW@aspeedtech.com>
References: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
 <7178e816-4cb4-49b3-9a1e-1ecd4caa43ed@linaro.org>
 <SEYPR06MB513414A5AE38EE6749A2902C9D7CA@SEYPR06MB5134.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <SEYPR06MB513414A5AE38EE6749A2902C9D7CA@SEYPR06MB5134.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/06/2025 10:20, Jacky Chou wrote:
>>> This series has been tested on AST2600/AST2700 platforms and enables
>>> PCIe device enumeration and operation.
>>>
>>> Feedback and review are welcome.
>>
>> So it seems all PCIe RC code is bundled in a single driver and there's no PCIe
>> PHY driver code, is there a reason for that ? If yes I think it should be described
>> in the cover letter.
>>
> 
> Yes, because our design includes the PCIe RC and the PCIe EPs.
> The two functions use the same PCIe PHY and are mutually exclusive.
> And there are different configurations on RC and EP.
> Therefore, we do not use a phy driver to configure our PCIe but use
> the phandle of phy syscon to set the RC and EP drivers separately.

I don't get why a PHY drive could not exist, it could be used by either
the RC or EP PCIe driver in an exclusive way.

Neil

> 
> I will add more description in next version.
> 
> Thanks,
> Jacky
> 


