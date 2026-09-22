Return-Path: <linux-aspeed+bounces-5040-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA30C982FF
	for <linux-aspeed@archiver.kernel.org>; Tue, 22 Sep 2026 13:28:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq1B95YScz2yQJ;
	Tue, 22 Sep 2026 23:28:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790083681;
	cv=none; b=Aexmo918eqbG6bpi/9mylEGyVBrNRwTw5ErrnIE/Ty8R1XLP2RYsr8rTYdzopUgAKaSXiBWCgD2nuFgCY39TwahNMYfZj/N1MC28bRaWISfX+N1BxLtYSVWEqKHmUVtmh3mDuncHxuU5KZCeQK3rjZpXGraLk1MAYqJufXlXlZcWvBRRWSOvaEUukYzs03Rn8qYyHhmxHsy6j15wWpoba+nfQ10U0XfwpHqN1OpdAKi0N8ASDDP+dck7KhdFAUW2Jf4zbVjSwFxu8F/sz8/6G6VrLabz50Vl2zqEiGtBpnIXwtVCzkPXpZzvNq34NWLm8r2S7WN5x7rO+8Ub3ELNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790083681; c=relaxed/relaxed;
	bh=2YIyBTYTKojaf4BmHidMuZkB2sDxpT30TjkIMwtTPhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MklQi9yhSJUOBdew5uW1c+A7WR3O7XtK3TPpXvpYSteVPLqi5T+Y6Le+BVxvMoTBWt2r8y7i1VyY9x4Zmn7Ks3lTdPqkbqIJU3gz4OTivayIC914NXzd3repOiljE31UrUDfGR55ZFlIbrJLEogH5Ga2LhteG1aIYkqvgeHZdXYE6GGjZC0opXYOHBAgblMcbgkJDkFdE+KpC9slkBRXZRwbNR8sy0rRqIgTJ2C0qwbCnGnKDIYDHZIkjWBAg9AfsjOAnCV/5kyIVhE46ikSBTQ5+xVcMgc9j//wQclVCjxNkdKHF+70aC0Jk2pVRda+Re6O6Lx0K/gYmIkJTgmQKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=MPoEryFJ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=MPoEryFJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com [IPv6:2a00:1450:4864:33::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq1B85Snsz2yHT
	for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 23:27:59 +1000 (AEST)
Received: by mail-ed2-x10.google.com with SMTP id 4fb4d7f45d1cf-6a67fa7a64eso6531372a12.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 06:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1790083676; x=1790688476; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2YIyBTYTKojaf4BmHidMuZkB2sDxpT30TjkIMwtTPhw=;
        b=MPoEryFJ791HMaAg4U9UOdFUntbH0Z36kD19lZ/1MuMZhaLcbX2xcHisujQYOuvd9f
         WNSS4ATJ2vOGDXehITWdpSz4H6RWSLPCu+lGVj+XuQZTZbBIQhOw0/YIfV16mLWd8mF6
         F65YLn/yL/PF9V7L5/EsBHmCC3i78Mnc1S3bPqSNvRR/TBKtGIHUM6E09Db37E46fKRF
         geWbpa/Z+WpRpHAJ5rkJWl9Yy1G8Ur+tt7LI5W882/vFawjsrVTn8MqhXvMSoIBhDMdb
         wL81OJrZNo1POxnPFla3C1F2/qDrf7n+ROSioRlxNqdvnzmVTvvJVC17WX6UgPmWvdxH
         25Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790083676; x=1790688476;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2YIyBTYTKojaf4BmHidMuZkB2sDxpT30TjkIMwtTPhw=;
        b=Sav1c+gqQRlTeIJGr6TonymMseXtdIuMlDClVV9ko9k5iME7gnv2juL41pz48KV/gT
         eGhHay13UOwZ/fyuPu4IT7HhBH+g2sOxX6xIVP1KDr/+6vtQSfQIzhlhJ8A30R1+Zd5q
         L1qpfyXqVegMBP7X6Ykj7nKDa/anN/vEQm3uCF4qxZ+bemlVYbX/aSBtx5NyWZV/729H
         zjijwjIAfWYzsMa3pBFuMMJtJMkylNGW5nTabObbvb+VZQ7bDtP80LUZrvoGe5opWRrF
         0zHEs4LBEtUhv1yd5jSkrviAO2He1toECM+YZ/zc2i1vFQrO8AABkv7/xn5wWwdLlJgS
         hXkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqRKrp2G4E3GN4vZ/AmhC/ji34ZQI6QKvhn3jnUcucadIxU793cjE5GZFvPXzNFf1ga30SCRUmM89Q8Wg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n4ikBK7EO+9l3XnPU7fk547l/0dcHHYXwvwawf/TszBN4xYxAQ
	jIJU8yxTOKZvX3iL5OGhqF1n+KdK+0z5h82uC825rUyXwNELJHZNeSxa2J8bIMwWEH0=
X-Gm-Gg: AYBFou3lb9dchNpLsszKQ2Zn2qNN9qAjKREzM1kPpesTj9vM0JHLBO/to9Ef/MSWFUk
	tHvpTiyHCNqZI6SAl/Hpc07XccSjv+tolotWMTKoIDq2Ul1zcHgbgBaMPF5RWJK+1jCsqCP+Mgw
	X2qYghbXjHQcmdSs2NQxreW4W8IE7bLB9AjAmKwaQ65643bFhwoVYy/575RmqNAdlso76uz1fn+
	nRp2R4zNEr5coftkaO7V01erdmdI/zDsZzn85vy09mS2ej12gmAs4m98R2yIk1IhPza8BxATRFz
	9wloiavsmmNfDP0TnCan7YqyGXozzFtELsMcoQnKc4SmvYJSYQua+EaU1/gZeUaG0ZIoVhssKq/
	R51l5cTXOGta3kDo0VwC6k2teK8MBTB+UjNfphttkZLQ+vyubh/fTkn4RbyZHYKYJY/cDBWRzMx
	5qt6w2F3MHVQVNghB5SVtf5tbL3kwXYGVuGlrM/rHbrcpTA2Op46OayNmL3O8yshaSNK9HA+bO2
	Zc1X2P8Ah7P5JWNsr3jF+2CiJhA5zthKoh7hjdzbRDnNebYuGy7NyLQlc77rw==
X-Received: by 2002:a17:907:948f:b0:c26:1648:a060 with SMTP id a640c23a62f3a-c2a15e0fdddmr1199501866b.27.1790083675881;
        Tue, 22 Sep 2026 06:27:55 -0700 (PDT)
Received: from ?IPV6:2a01:599:842:c46f:7b1d:31f2:7a17:2f4c? ([2a01:599:842:c46f:7b1d:31f2:7a17:2f4c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c54f249sm85420466b.21.2026.09.22.06.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 06:27:55 -0700 (PDT)
Message-ID: <968796d6-811d-434a-a230-f05da451252c@9elements.com>
Date: Tue, 22 Sep 2026 15:27:53 +0200
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
Subject: Re: [PATCH v7 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
 support
To: Prasanth <prasanth.padarthi10@gmail.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, ryan_chen@aspeedtech.com,
 billy_tsai@aspeedtech.com, andrew@lunn.ch, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <cover.1790079398.git.prasanth.padarthi10@gmail.com>
 <8cb38ff6-1210-4c5a-b0bc-b0b50dd2b9aa@9elements.com>
 <CAMFFDGjJcmpaQYHe=F+jpstbdk9-uXPKkBxLkJqAJRiyyTkBvg@mail.gmail.com>
Content-Language: en-US
From: Tan Siewert <tan.siewert@9elements.com>
In-Reply-To: <CAMFFDGjJcmpaQYHe=F+jpstbdk9-uXPKkBxLkJqAJRiyyTkBvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 3:26 PM, Prasanth wrote:
> Hi Tan,
> 
> Thank you for catching these issues.
> 
> You're correct about the defconfig. I used `aspeed_g5_defconfig` for
> the DTB build and incorrectly reported it as validation for the
> AST2600. I'll rebuild using the appropriate AST2600 configuration and
> correct the statement in the next revision.
> 
> I'll also carry forward Andrew's Reviewed-by trailer for the unchanged
> MAC0 and MDIO nodes, preserving the scope of his review.

Andrew has already resent the trailer, so no need to send another 
revision for that.

Tan


