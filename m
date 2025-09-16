Return-Path: <linux-aspeed+bounces-2234-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8561ECAC598
	for <linux-aspeed@archiver.kernel.org>; Tue, 16 Sep 2025 11:33:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cR0Cn128Kz2yvv;
	Tue, 16 Sep 2025 21:33:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757982372;
	cv=none; b=GKyZYwQaK+Ev/7WBfM2IdvOeLzTgYD6F025GM5Si50Dk+3TDJUuFH4iG2tacsDG6O9VHIvlnKKgHV/y+LxSzr5eBi1mY9APvoJXhwVDOFnMGMWRCAMivRgf6oVzu2FTkfhkAnh7P5eDqAUZ8hwskcsr0V0Xb6mok5qesQhVLEDAusf1yXuUZlcuIgbApekAFrJv4dcw+Ili2xasPx8DC7Xn0+EhC4L9P3wek95ng8WX/NVzECuqtYpsnLSQslfSydip7c5vxIhlsZWQXJfnvDOPdJVCy01fBcF0d17Jzada5OTLMviF17zQ2rLGPRQWc42mNsKFjeO/uE7zz03OBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757982372; c=relaxed/relaxed;
	bh=OMHUdaciQEUphG0YAP/vw1pJBdgfUfPJFNc+8L14fKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g++SFBpnWACzCud5Azn2EMmgHiDVPnQwfgZNDuDExbv3rvvFzdagCqwFg1wGyCdn2/t9dxd8TaliLDJs8w2QT3RXEPhRX5ygYMh/EfjsMz0aDXIJZXTX0exICIdBUpjQDF8OSulcPTo07KHAIfjdFUYB/+XWp8Tnk6ktZ2tQpTkgoH2L+R4TAnZfvmfDskJdfSwsjrU6vc+P5mer3a8l0trQcXMjyPE15DtuU7oGs2fPNIq0Br/OBrgYTOMglyX7vSKOv4oDJhaiOUw7LkqDnXMHR2JtzfRDQR+p6pCEZNKKeVQfEAlkBDVJu6xjxgOeUZZDI312gzSJyG8sCc1dZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=h+6R8rQM; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=gJnc1JZR; dkim-atps=neutral; spf=pass (client-ip=103.168.172.159; helo=fhigh-a8-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=h+6R8rQM;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=gJnc1JZR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=103.168.172.159; helo=fhigh-a8-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cQjPF3bKMz2xnk
	for <linux-aspeed@lists.ozlabs.org>; Tue, 16 Sep 2025 10:26:09 +1000 (AEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5693E14000F9;
	Mon, 15 Sep 2025 20:26:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Sep 2025 20:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1757982367;
	 x=1758068767; bh=OMHUdaciQEUphG0YAP/vw1pJBdgfUfPJFNc+8L14fKw=; b=
	h+6R8rQMQZMbVkvm/8OpxCafDntSB5HiLMPjv0ycnPhwN/XAwfDBVUkrz0xt43LZ
	Cap4xH0Uz5G30lOf0prvtqtuCLpdbqE9vqIIcfpbkTt/N4MqpDjz2mNa9ECH3E5H
	NYUKoD4VpumGD1d+Sh0qXw/W1SlxW/OWe8XgK8IUdC9eX2ekBXElAflsoIryeHrR
	3eo1t2wWr7RamCdElyHbKH7u5DmgZAx4oNU7fr+IUicdcD78tJqOGNAowEv2AzJg
	3UVLeiqkStup83o0YZZFTqnT3HK9q9dn2hmIoSsgCUvJz78YkCIoRKpQVUkHbem7
	SMUJbMLZRjXl4M4uSSjtLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757982367; x=
	1758068767; bh=OMHUdaciQEUphG0YAP/vw1pJBdgfUfPJFNc+8L14fKw=; b=g
	Jnc1JZRxWDrJ/YxbKbUTXHzuXHnNO5Yst4vX2QRGSHGD1OSWjdmpFs63+e0Odi0I
	/IPprkPLQKUSelb6qnejzjwE9IsG/kZ6e8+zN6xz7NoVV9FeY82mOyVMuOG1V6oI
	XbN06nZFFjz3+Q2smFVTNqReeG6lH71C12yXp3XyUZAzM06PUd/mq51aihr8xFS8
	OcmTfmlQ+Jb2/JKuN6zFyTzXx/UW1WToJyrPPkFKPMJYfu5wafrDczNpjYPNdQij
	alClrGyMsU4R1Yav9JNJ+ix5pZLmnvLdESbzCNcooq03sTtXMKIV1Wm/MdqLl4Hk
	dcx5darB4s6TF50ZFcymA==
X-ME-Sender: <xms:nq7IaNC8LclF1Q39bRVq820D64NwFTSsMh9yGIhvRyzrKEuT9VgaAw>
    <xme:nq7IaKtfp_9tdRuXbQSIcuNnTb674NdvHWGB_yot10CrGqw-J9kEPLDuNVssGVNjy
    RPE5UXKxcfkZ7nuPqM>
X-ME-Received: <xmr:nq7IaLTIDHMBwS5kjupfqID2xlaCGoENQr_iNK29R6HIYs7I2dCxvyyha1fN9qq7A1jMJdnY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefledufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptfgvsggvtggt
    rgcuvehrrghnuceorhgvsggvtggtrgessghsughiohdrtghomheqnecuggftrfgrthhtvg
    hrnhephfekvdekvdfhtddvteehueeuleetjefhieehjeeuhfdtuddtvdeguddtkeevlefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvsg
    gvtggtrgessghsughiohdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhope
    hrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohgvlhesjhhmshdrihgurdgruhdprhgtphhtthhopegrnhgurhgvfies
    tghouggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtohepuggvvhhitggvth
    hrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghr
    mhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqrghsphgvvggusehlihhsthhsrdhoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:nq7IaBJmBF_j__0JuQ5MHQ-LYvwEytGwCYotXI2b9j_ksMMQ_egk6Q>
    <xmx:nq7IaOve2U-arkChzWhmTL7q5MiUHiNFTmBFdiC33dB6UyVEtaPaEA>
    <xmx:nq7IaI-iOU_nq89e4WIck3KrOlT1CYuxrI7QOLLGqxZ-LNXKTkYV8A>
    <xmx:nq7IaI2CaYyDTUeKRkO7g5Xj7PEG49K-HuXlRy3fABbX7ctCrJ5toA>
    <xmx:n67IaMD7FtHuDwd1vsvSnOTu6SLrJYS-MeUy0frF1-abbsf6-RuIAB5E>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 20:26:05 -0400 (EDT)
Message-ID: <5ccc4945-87f6-4325-b034-ca3f2f90257a@bsdio.com>
Date: Mon, 15 Sep 2025 18:26:04 -0600
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
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250911051009.4044609-1-rebecca@bsdio.com>
 <20250911051009.4044609-3-rebecca@bsdio.com>
 <58a092c5-5dd0-4718-831a-e25ecb184087@lunn.ch>
Content-Language: en-US
From: Rebecca Cran <rebecca@bsdio.com>
In-Reply-To: <58a092c5-5dd0-4718-831a-e25ecb184087@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 08:09, Andrew Lunn wrote:
> There is no phy-handle here, and no mdio node in this file. What is
> the MAC connected to? Does it connect to the hosts Ethernet interface?

Yes, it's connected to one of the host's 10Gb Ethernet interfaces.

> RGMII pinctrl is referenced here. This opens up the question about
> RGMII delays. What is this MAC connected to?

It's the AST2500 MAC2, connected to the management LAN ethernet port.


-- 

Rebecca Cran


