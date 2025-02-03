Return-Path: <linux-aspeed+bounces-605-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F59C02190
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Feb 2025 04:06:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YmXwl4ZcGz2yvq;
	Mon,  3 Feb 2025 15:05:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738555559;
	cv=none; b=GpXhHTH2zKPPvqNo2tW6QB/QfRnIxXNuYlSdVJVTEUKG+sjhcrqXE7pCYNNvBcKYG7sVDzi/k8GOCl9hGamccNmfz4SSZhhPCWh2kk0tLa5UE1K8Zuqc5TnBLubwgQLZcMYNU4jAIJzARHtPicJfU7s3QHZXoNpRAwW1uIiCzD63tBftHb7gIyBjBo7stqHGpk7LSIqL8+3PUc/mlTYEObHPtFvFtR8Buuljejw/60KIPsgObwNfIhkR4G8XX6i3TQ8zpMIuMj0bS74GauTvzRgaTHKORw2cjXZ6kni91URS2Fz7Sy7sx/I1JZadJQBt2b8ZqPbb4t2S52zeujHRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738555559; c=relaxed/relaxed;
	bh=EfiRw7gB8e/5MLrWL0BiJdfLFcVW2LHs3Jq0FFdnVo0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bPr5dNEt2wsZT63jYupNsaefWb+TyPvNCR7K15gKtvjFWsjVhEPphNwKXMt8XSHWuzpLUT5m+Pz0BBb4m5ipebP5JjF5RVbw1AzK0xzlZpHdexdZLL4RH2/QucuIK3+ZXIfGUrHQoNAcjJpTkbnG6kty7ocmRqih3kyqK3eQI5nf73BN7jP7c+oXjrAe9PYy1xySsNzwNEGkS4uW8cPqS89S5yTczLRhntnXKx//7h3ZjOH/qNMGqoc2QJ5TaM9KlC29cZyjliRsOg5HdjixmooIACVSbhaISNQzfkieJp5uzRMkjgoDIYdW29T6MsC+Ses4cevJCN0uK/db1MZDwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=WqdTiAAe; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=WqdTiAAe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YmXwk0b0Sz2yvn
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Feb 2025 15:05:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738555556;
	bh=EfiRw7gB8e/5MLrWL0BiJdfLFcVW2LHs3Jq0FFdnVo0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WqdTiAAetAQKzDnEKAxG/R3ri9ZP0gG2mu2AqTf9zfCQLmvqRHEeqcjlFbxI8q6Vy
	 YF5PJSeqgtcjFe1LFbJC7ga2/nTFHbxtubP0f891BE/g+tFzX+zAEmsWPgNql1/yKH
	 uHiZzlkHo2WpAr8ze2u9IRE5+90PhFevbqvS2n05CB4w7oDoh04u/2/NzwBDNdx5IU
	 YFqjgAhGJsfgGdg4jsPZzQSN5fuH55Opp9YUfK3r9NjHNEIBHIchSz5Z/eKcreUbdu
	 u76oHkujWbGyHwDUgfpE207FzjXJlYYVk9mp1TR4ZW1v5gqJmFWdMqaVj5IAEVElvk
	 /VSJ7VAFCHPzQ==
Received: from [192.168.68.112] (58-7-156-140.dyn.iinet.net.au [58.7.156.140])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BD4E773C54;
	Mon,  3 Feb 2025 12:05:51 +0800 (AWST)
Message-ID: <f01ea3f0184cb598cdfcc22d304ea31ef5b7dbbc.camel@codeconstruct.com.au>
Subject: Re: [PATCH v7 1/1] watchdog: aspeed: Update bootstatus handling
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, patrick@stwcx.xyz, 
	linux@roeck-us.net, wim@linux-watchdog.org, joel@jms.id.au, 
	linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Peter.Yin@quantatw.com, Patrick_NC_Lin@wiwynn.com,
 BMC-SW@aspeedtech.com,  chnguyen@amperecomputing.com,
 aaron_lee@aspeedtech.com
Date: Mon, 03 Feb 2025 14:35:50 +1030
In-Reply-To: <20250113093737.845097-2-chin-ting_kuo@aspeedtech.com>
References: <20250113093737.845097-1-chin-ting_kuo@aspeedtech.com>
	 <20250113093737.845097-2-chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Mon, 2025-01-13 at 17:37 +0800, Chin-Ting Kuo wrote:
> The boot status in the watchdog device struct is updated during
> controller probe stage. Application layer can get the boot status
> through the command, cat /sys/class/watchdog/watchdogX/bootstatus.
> The bootstatus can be,
> WDIOF_CARDRESET =3D> System is reset due to WDT timeout occurs.
> Others=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D> Other r=
eset events, e.g., power on reset.
>=20
> On ASPEED platforms, boot status is recorded in the SCU registers.
> - AST2400: Only a bit is used to represent system reset triggered by
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 any WDT cont=
roller.
> - AST2500/AST2600: System reset triggered by different WDT
> controllers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 can be distinguished by different SCU =
bits.
>=20
> Besides, on AST2400 and AST2500, since alternating boot event is
> also triggered by using WDT timeout mechanism, it is classified
> as WDIOF_CARDRESET.
>=20
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

