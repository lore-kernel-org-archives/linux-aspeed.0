Return-Path: <linux-aspeed+bounces-105-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA68ED5C0CF
	for <linux-aspeed@archiver.kernel.org>; Fri,  8 Nov 2024 14:08:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XlLPm19H6z3bwp;
	Sat,  9 Nov 2024 01:08:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731074892;
	cv=none; b=T30ss8owD0Qu6bCbKbh2O+mkEd3RlHTELssCqEorTWyjjJQKEZ0GsozBYF6Phn02zHVOilN8ovGO0d7dQjyHxjI8XykMW0xRwlsy5pLiEwx/f5jTlg2LWwoBjOB4+2zdu/qKdtCTr3Fb/YwUhN6JCd29JubCHrCbX+jgP99su4ejbMBKwTWVeN0KNSiwFKCJY4NI7CMPTiAxU0XoXragiBFz4pJvqQYgdzhYS07ZXa0N2BlO1us4qZF1YoSUfMll58NlArXZeVkW0yyjuh7cQWdaazWfHF7nRQAzSOtaTiRbLQtVkDqWDm5tckW2fReKMwyD4DvK03PyITovmwLGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731074892; c=relaxed/relaxed;
	bh=MDA/YnPw1q979OydzNA3RQek3PwG3C1LVM/KL/xZqYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRIaehmiga/N9FqSrxLIHd2LBfRCYjrgweUEjVBUS4BSRjD5o791wZcAORsywYodrGJGdnZw/GZSMIcML2a5X4phLLcE7XSdIzw/DV7qIcfDSfsG8TAudiE8bfAmZzxgw14FgnT/W8kI2L2mAw4F/idDjGP/lvOJXA3s9qHmxFBuFxTQAGaG/j2KxThX+npfSBg2AWpIW6LHo0PxOhmQ+pllxotCAcONqnBsjDj2ErRwYgyy5fiYwiyI7s/VY6/dm3swFPqPQk+mEA3TcM6PRkmSsrCUbjBMd3ujvrB8V8go6DMfvibsfxTee40PzOf48KEzVF4suuu6dJoO8us/qQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hxJX3RuJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hxJX3RuJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XlLPj62rTz3bwk
	for <linux-aspeed@lists.ozlabs.org>; Sat,  9 Nov 2024 01:08:08 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-20c693b68f5so22921325ad.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 08 Nov 2024 06:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731074883; x=1731679683; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MDA/YnPw1q979OydzNA3RQek3PwG3C1LVM/KL/xZqYg=;
        b=hxJX3RuJOII7Ngx+6/KhPGhz38uiLPRmqMfBTJGG4jA+6bM179XvGiP5kA+MsVqU/i
         Fe/OyeLl0RclW+SOnbSNSSdGvfiqCx8B3/4N909uvfZdFKu8osxGW0nmUXguRx98F1IL
         R0UUbRCtcbL5cq7ukPvLYxym6J420mztOCgD8BTy4AG7DGrlIsMlLRn2HXOkJvH2rmIS
         1A4ujSQ+Nz/PnXn5w5sx0qgYnRhvcQcnOMVE+VE32XSFNbAAVKFrfe9mlJXnTi8it8O9
         eCrNKuFLpR1qw5f7vEP3/fXwg72LN3+cuGAO4mn+6j4pMWwxpj+vwLujGEGMZdses1SA
         yQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731074883; x=1731679683;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDA/YnPw1q979OydzNA3RQek3PwG3C1LVM/KL/xZqYg=;
        b=Fwkmzk+Iy7xtlgFgYfYlf74kvdcJQiGNZHWMHCh2sWSNbYMJdqoAkXQdlVD5EV8qxD
         cYNEHof3j4Ywuj4sgAVrsAvJwyixeBtEWiwNmeobwmOe710UgWsqVbYEHZox6BfpCTPd
         vSAQ2DLrSadolrdvkaMkXwgMGfP2/ABdN9fw83j90IXk0XK0Cm5wvqy52G60iM7mRt2v
         PpAyREpgTZ1TxU+8SpNlfvehPC1w6a0WosrEAL9/n9nDovHnnfoz0qfRkIl7jWVN5Fln
         P/JxKe/XhbV6pcakmNh1J6UNK72QGWRmmn3pT3ZNMP8yBmjlg70JmZx/DeRfG5aMo2Kv
         Qh7w==
X-Forwarded-Encrypted: i=1; AJvYcCXCXfWaXvF1DVfFtogfhLFPC0759jwy70vGOK03gv/LA/+/c0///sMepLbk6l36RNAGNeKy1Ra8TQ+o2xs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxbEjx0YZJyRHHAX565rwyGLP3KW1mUpbRvbWJm7F8z14oeArmG
	rdpGd/NgnD9auLq7AnvwTIOSz9kw9NBR8xlZHkcluO5F1ccAWn8QmR3rQw==
X-Google-Smtp-Source: AGHT+IFgkItELd0W01lweMUWk3BaIPKK/cfRmmwUw4c5FH32ummS1mrI9WYYmto2+9cJdiXsPPWbrw==
X-Received: by 2002:a17:902:c942:b0:211:a6d:85dd with SMTP id d9443c01a7336-211835d9930mr35684205ad.47.1731074882693;
        Fri, 08 Nov 2024 06:08:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5cab66sm3454618a12.33.2024.11.08.06.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 06:08:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9a1e64ef-81d9-48b0-b871-ce4ff792eae4@roeck-us.net>
Date: Fri, 8 Nov 2024 06:07:59 -0800
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
Subject: Re: [PATCH v4 1/3] watchdog: aspeed: Update bootstatus handling
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Patrick Williams <patrick@stwcx.xyz>,
 "wim@linux-watchdog.org" <wim@linux-watchdog.org>
Cc: "joel@jms.id.au" <joel@jms.id.au>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "Peter.Yin@quantatw.com" <Peter.Yin@quantatw.com>,
 "Patrick_NC_Lin@wiwynn.com" <Patrick_NC_Lin@wiwynn.com>,
 "Bonnie_Lo@wiwynn.com" <Bonnie_Lo@wiwynn.com>,
 "DELPHINE_CHIU@wiwynn.com" <DELPHINE_CHIU@wiwynn.com>,
 BMC-SW <BMC-SW@aspeedtech.com>,
 "chnguyen@amperecomputing.com" <chnguyen@amperecomputing.com>
References: <20241101121201.2464091-1-chin-ting_kuo@aspeedtech.com>
 <20241101121201.2464091-2-chin-ting_kuo@aspeedtech.com>
 <ZyUcIIb1dtoNhX00@heinlein.vulture-banana.ts.net>
 <a0faca9a6ec7f4acdfa2f29b4ffb94b5392aea6b.camel@codeconstruct.com.au>
 <TYZPR06MB5203053A004676F51322DECFB25C2@TYZPR06MB5203.apcprd06.prod.outlook.com>
 <ed77d57facaaef0be796b4c6a742dc7bf3bff479.camel@codeconstruct.com.au>
 <TYZPR06MB52039B02B6D3053355F30489B25D2@TYZPR06MB5203.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <TYZPR06MB52039B02B6D3053355F30489B25D2@TYZPR06MB5203.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/24 21:42, Chin-Ting Kuo wrote:

> But now, I think it will be better to add a patch for creating a new
> reset reason, e.g., WDIOF_REBOOT or WDIOF_RESTART, in watchdog.h
> of uapi. Can I include this change, creating a new reset reason, in
> this patch series? Or, should I create an extra new patch series for
> this purpose?
> 

This is a UAPI change. That is a major change. It needs to be discussed
separately, on its own, and can not be sneaked in like this.

Guenter


