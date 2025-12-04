Return-Path: <linux-aspeed+bounces-3040-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A429CD2CDE0
	for <linux-aspeed@archiver.kernel.org>; Thu,  4 Dec 2025 22:56:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dMqcX0bmGz2xjv;
	Fri, 05 Dec 2025 09:56:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764882769;
	cv=none; b=GdqnYxi6ZjAe2O91EJ/ELFYGNgXUp7IlGXOj9RHq6ouKb4OsqMWjnWT+UuKdiJl9cwF1guQivfgrSbQo5ECHu7EXifh6e1s1AKO880foHEs6siJ5aFZpws1WZgkkvXCHmbw0xfpcjKVJtpYe6+yhbVmn/QjNKGSYdBJ8FYoruYMibLKTnj+X0mLq63dkR2tN80/oAJ/dfprKG+WaOtBJDHQh7vICZ1l+uR91Sei13PCQolZJ49SIHtrwxFNaxMW2A6/8x9LbFFEYxFXrKReszh9SCvqOlF1bmK3JFrhHQDla104JVxe0ozGP30NtrfpMmomiLONfjvLaD2Y0k3XcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764882769; c=relaxed/relaxed;
	bh=P8rDSBosyaMHHGMgfwL6ah/RjjEKBsK3EiEwa44oQ4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKSkautcrqF1s69sYSZnjO1EeIwFJnXJbl6D5DdqqmZnzQTy//EYuYJL+7GpNYROCGVXgjRH3HI95oAOySQU8UeIepVkc2FYXQRviMHRT2uxIGFxBdvknvPjBAjm0fotdz8vVilZmehwaRFgZooW0zwMEeCrwRuLF8KNb76y0nqN1VGZSOvrUfbd0YOHKdMB1Q/FtyAT4b4z7mQJ39LsdVukn2QmTd7EOlh+HTBqnlrWkvU7zBu629O81UXGrSbsolGRUcZX8QME4yYST5zsn+9lTBYMpzH4og1dOF59d5TYEYpCuPbBNLW5oTFeg9FTjsgsUfzD5SXas32jCrOZLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=tnNdDod2; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=VGB1BI0O; dkim-atps=neutral; spf=pass (client-ip=202.12.124.153; helo=fhigh-b2-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=tnNdDod2;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=VGB1BI0O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=202.12.124.153; helo=fhigh-b2-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dMnKF1Dhdz2xGY
	for <linux-aspeed@lists.ozlabs.org>; Fri, 05 Dec 2025 08:12:48 +1100 (AEDT)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 068817A0198;
	Thu,  4 Dec 2025 16:12:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 04 Dec 2025 16:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1764882766;
	 x=1764969166; bh=P8rDSBosyaMHHGMgfwL6ah/RjjEKBsK3EiEwa44oQ4A=; b=
	tnNdDod2Shlp8HR6zj/fS1KyLmdm8vtIybs9fREYVeI0qrnc53vaV+b6o8Ke4a+5
	eAJ+YAkXg9efah9HYUpynjwfT+4EQXHti0RLsTqjfrxX1sulIl74af2+9JnwhtKk
	jA1KIMErd4TdnsicaA8OXL3adMAfprqpGgGNtiXZvHFpOBCHQeOIBuTb9Z9DTn0r
	9NbownJt6dKEvLA7MVd3CXK/ciCgFmexBhZOr0wxwUvbIpiVd6k8rFcK/ZexNrIr
	BdQndNP+lcCL8KRTOrUsaeogPZwPJpyL9d3ZpVCD4UK/jt8Ye/u616UwbKgoJF8U
	BEo+TVPvztXm6bW/TwWSrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764882766; x=
	1764969166; bh=P8rDSBosyaMHHGMgfwL6ah/RjjEKBsK3EiEwa44oQ4A=; b=V
	GB1BI0OZpDyWm0VHuUger3MwnDZ1j32bT7Yi0F/h4KXDimEzpYzupoulvSbaE2KR
	sJmY3mMXycZKPG30VFrfgifyKisH3y6jtBIgIvxGhYr+XlIVChKX2I+nyag1n+ef
	Nk7FhxdmWG6KzaD8mpjc8ukOh1My55JQCZadTYCwM8uWgagwSbknk6TbIRgT/mwX
	b0rVL45c8rp+As72wca0D1ckgHJBh1oFlgsuo0YWi7LGRK7fAVbZzOI3EccSxnAd
	x7QeYk8k1CRduhzAeQeLCYuSh6Iqt0PNUEcJb1vnxEHuyAA/z40naGg2bP2APBFU
	MDefVJHdWXBq/z220a30g==
X-ME-Sender: <xms:TvkxaYFldMANraKuSdHexhMGbwdoW4bnhB9JEEzNZb79_GoH9FrgTQ>
    <xme:TvkxadPwkew562iZPP4Ks59LwnsG2_9H8OItIXRvYyFx_zO3x9Bd6kr56XejQ5Rew
    B20_HYIedf3nTScVYUc8FtuEWsX78gJgImOpI8DDEWG3yFEtT8bQjw>
X-ME-Received: <xmr:TvkxafI20KRqw0CFOu1jFb_unFDctGdMAkANA6IMp6j5ibVVcccpPoZJzkO6udiRsfE1pKU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeiiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeftvggsvggttggr
    ucevrhgrnhcuoehrvggsvggttggrsegsshguihhordgtohhmqeenucggtffrrghtthgvrh
    hnpedtuedtueevtdetkedvheettdetvddviedtvdejffeuudfggedtgfevgeelgfevleen
    ucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvsggvtggtrgessghsughiohdrtgho
    mhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohgvlhesjhhmshdrihgurdgruhdprhgtphhtthhopegrnhgurhgvfies
    tghouggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtohepuggvvhhitggvth
    hrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghr
    mhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqrghsphgvvggusehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Tvkxae87Tn7qOmZBCccMFcLl6nYNIIlPpaVBZ1_jqvd08Rlh3JRzFw>
    <xmx:TvkxaTF4zVvxTdJeE05vyyCUKeWTRSbh4sg0R7MlD4BLIx9X5o2JUw>
    <xmx:TvkxaR5wUi5Yhz5JCYeznU2rPldi6lpSun8sBY7Rmn5EIjttyD7GcQ>
    <xmx:TvkxaUZHB3CF_glz9kd8s0bEoLxn7ybw0qDDa0y95_lUTIfkhS98IA>
    <xmx:TvkxaWjaJWhtUVtSMSfQRmURwCcE_oaNp9jnlfiupPgKYFfrxKYnFZKz>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Dec 2025 16:12:45 -0500 (EST)
Message-ID: <4e61c405-8495-4285-b848-04398f87ac9b@bsdio.com>
Date: Thu, 4 Dec 2025 14:12:44 -0700
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
Subject: Re: [PATCH v3 3/3] dt-bindings: hwmon: (aspeed,g5-pwm-tacho) Move
 info from txt to yaml
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
References: <20251204210238.40742-1-rebecca@bsdio.com>
 <20251204210238.40742-4-rebecca@bsdio.com>
Content-Language: en-US
From: Rebecca Cran <rebecca@bsdio.com>
In-Reply-To: <20251204210238.40742-4-rebecca@bsdio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 14:02, Rebecca Cran wrote:
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.yaml
> new file mode 100644
> index 000000000000..b23c3519604b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2023 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,g5-pwm-tacho.yaml#

When I renamed the file from aspeed,g5-pwm-tacho.yaml I forgot to update 
this id line.
I'll send out a v4 patch in a couple of days to gather any other early 
feedback.

-- 
Rebecca Cran


