Return-Path: <linux-aspeed+bounces-2752-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93281CCF9F8
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Nov 2025 17:51:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d1tD218Wcz30Qk;
	Thu,  6 Nov 2025 04:51:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762365074;
	cv=none; b=iv00wWm7+luQmqoQFBL/hFJ66Z8CkfPRgKXiGyGsVDgws5F+ksIIri+aWyADOBewzmDnBubl5ZtQZmXwOukmQFm+ZKgng7oLgYdHcdVg81VAJglKTOXesxJ8wkrx4tXJDR8KyIGsRA7DZL1vpv7oUPMBAwFsbFpbG2//p0cH+c3mbRed2MGyu4pijc2ViaRfx4QpK6EpdVRk9sna6a7pLEXBXjWIAlf8CrQ4gZ3Ww6hcik1yNSmm3kT1xA+ra+zSDv8yEEfSqGUezaWnDCgMzC6RtRBKTWgfsfc5zr31odneb6rnvWJx3ei7tm1jir2P+97/fFctoDiRnLS2rgMZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762365074; c=relaxed/relaxed;
	bh=062oThQfCiAu6RO0RcHJ7UUZxncftkZICnZEVJAs4lo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=IkDuyqZ8iTsEhbp9AGba8If0E5hSndN50dLPrN9bEEql9wLjc5xljsdi2uNJl/gQ77OcMSYkOy6mQlXsgGhxHw3BSvtM38S8Ggq28QbuA7cXXzZOo7gUDveSej9DlM8hk+JHrDk42jQX2Su3XtVy8CrIifAMC7kq94aOJu0CIH3zYoqnI3WqZmi/4DPCBO7TxcswvCwrW/MlKo84FHdG+r0xcG3dfPCpSzx7TpMq6aM8Pxu9E9D7wVcPYa9b0ou/mcAYNE16VRE5Z9BzXgIhqAgWjeN9bdvC8jnDBmJ00e9GXWX8nFVolvpImoe51kzPLP8jgRKxNwHekIc/1N+Y1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Ln7yNtw6; dkim-atps=neutral; spf=pass (client-ip=212.227.17.11; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Ln7yNtw6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.17.11; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d1tCz34JSz2xK5
	for <linux-aspeed@lists.ozlabs.org>; Thu,  6 Nov 2025 04:51:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762365057; x=1762969857; i=markus.elfring@web.de;
	bh=062oThQfCiAu6RO0RcHJ7UUZxncftkZICnZEVJAs4lo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ln7yNtw6TkVdvl6qXBmEc0Wv8N1cE0i5ML2yosxtdNYQ6Sv6OyltoAytKsUu9dF/
	 t8UnjbILlt9gWiIkeNhD3bGSx7ViihWWKrERBltSJvmkM4FjKlfKcZUXfPcGAFblh
	 Qngs47aj6vVcySnDidnhVChloU5nUbBoDcgVk8EwnIz/i3/gdClRJ8Fn0fZyS+hPf
	 F69AwzeFd7dk5w3kjuSx74gxlBugFGgeRw9r2fnNO24J8vhn+YgiISKKkAafJ2hIN
	 6vZIFU4HRqtmjbojzU6yUyNGcbkpWek6noocES7shlHX8rGB4c/1tzIvHv1pz8czN
	 nznGPvIRxNrDuxgfwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMGuC-1vYuvu05by-00Hw0X; Wed, 05
 Nov 2025 18:44:32 +0100
Message-ID: <1a234e96-b41e-4f6c-b23c-e57426ff6aa1@web.de>
Date: Wed, 5 Nov 2025 18:44:27 +0100
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
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, linux-spi@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 openbmc@lists.ozlabs.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>
References: <20251105084952.1063489-1-chin-ting_kuo@aspeedtech.com>
Subject: Re: [PATCH] spi: aspeed: Use devm_iounmap() to unmap devm_ioremap()
 memory
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251105084952.1063489-1-chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jot5tDQJo1L36cL8JOgENIFyiccB0wx8wvoPXnsvMFO7Sx3sCtA
 qDsGMlMmcQ2G1W/kFisssqz4WcxD4S2GeztozjrMc1rGpu7fh2OWU3/BgAAJUJXdzmCVbdC
 pVeLpxkUuTNVafWFIW+Axl3Qcxz9aLGDtldOUyCrvVFAi/vxOOA9Q47kD1xIZECAE0gl0JU
 Exv31t3Z6fWyvu8AgoBDg==
UI-OutboundReport: notjunk:1;M01:P0:qwGfcf/aY6c=;hMVy17oG/FLsbX7X2LyPjwRVUvu
 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
 T0533g6MIey19A==

> The AHB IO memory for each chip select is mapped using
> devm_ioremap(), so it should be unmapped using devm_iounmap()
> to ensure proper device-managed resource cleanup.
=E2=80=A6

* You may occasionally put more than 61 characters into text lines
  of such a change description.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.18-rc4#n658

* Would another imperative wording become helpful for an improved change d=
escription?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.18-rc4#n94


Regards,
Markus

