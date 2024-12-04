Return-Path: <linux-aspeed+bounces-179-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BADDE7716D
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Dec 2024 04:09:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y33tP3YQdz30VF;
	Wed,  4 Dec 2024 15:09:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733285341;
	cv=none; b=Fh7LjvpCCATsSMiV33o+YkxMHPQODl1Q+NVVuLLyZd17xsvRf6CugvNnrH8Z2l0R36zIl6BA11q9hCv2wwTzR63nkpc+gIYETxOPRHV3ZH/VZTO/r4cAfldM+BCal4iyhLZEjogPCzAh00UuOGnT+nhlEcxQdJ4qosNUpJqL+OqargdmabYkXdP3QtzgzXr836X8pk6QH33X4MPpq9D9gOVPyHJ4t4Ih6Hrdhs3v4AKPBiBk1ds3BENFMMgJpbw8f5zNn+dKicIHdFrPiZneZLlpVpo6A3gzYZJoZKZtXchIQ7jPby2wpF8AyzPWpI3rFrwEiQ6oWDsX5WGRqKxAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733285341; c=relaxed/relaxed;
	bh=LrOFYJV2ZrZYy6LgVD19Et9UmHlo6S9eT8BWN0Eq0bQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T8S/MbgBa26KSaVX2vqlrcbdOchwfU3NQERjdMIE+y8iMO0cLq8V5VOv/krPM/Al5c2l58H+I/GwKhJcbyTKUPoARCfD3YykbcpitfpZvn3ovEfEXIPgZuEvInIeywZNUIRDczFLUFYgSVPRZwS1KdDTmbmx/MkoMXxKMge3X0Lfz1BvJDU4tNg1b1QMlOz+Cgkx3EYUbnO5G2lLHdHvC7lNIHslcYcbzRGKtkvWd/l1OFp29Ekg8E79SULpO9V8MrnQgaxLA3Dv6uv5ZAbV5T8m/NJ5Qx9WafK3OXsi53FqCwj//3STfSgLJkfE7WeXxZ6chSe4xHaKaxe0iraXmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=DJrluDAK; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=DJrluDAK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y33tM4nHTz30V1;
	Wed,  4 Dec 2024 15:08:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1733285336;
	bh=LrOFYJV2ZrZYy6LgVD19Et9UmHlo6S9eT8BWN0Eq0bQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DJrluDAKGeNcgsdW3x3ei/ik/ffQfZJIkBG3/v2CrO1qnlv/S7WLHQPFrZ3zuEEHv
	 Ql/kiy4lRF9SdAOLkNiMVLcm4qOlIt9pzcAHvDatDUiW7rwKAUEpHE+MusHS3ffky/
	 TmH8r50SqdUbjnz+i8N7lzhba4EMsUiqJGe8fdWAGRVfbpRK1e1/6PyfyM79sh+Nym
	 V6l9PJU0fiY0HD1KxdcqrZsUvdezusjkCVZ5bqhdgVaEBm6Fiwf59SE6TgvQwUZxzN
	 U1JQevi0+nyNR+LxqBN31xERHHWhB9pSYC/mbEyXjNpwXieFBfT65zhuVx3PzaL4yb
	 6pTB1aWUb035A==
Received: from [192.168.68.112] (ppp118-210-165-44.adl-adc-lon-bras34.tpg.internode.on.net [118.210.165.44])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C3CC96D6B6;
	Wed,  4 Dec 2024 12:08:54 +0800 (AWST)
Message-ID: <9ff74b8a13ff58921a4f7f18dbded9c06b195c06.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: Enable video engine for IBM System1
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: manojkiran.eda@gmail.com, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Eddie James
 <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org
Date: Wed, 04 Dec 2024 14:38:53 +1030
In-Reply-To: <20241203-dts-system1-video-v1-1-008e5e660106@gmail.com>
References: <20241203-dts-system1-video-v1-1-008e5e660106@gmail.com>
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

Hi Manoj,

On Tue, 2024-12-03 at 18:52 +0530, Manojkiran Eda via B4 Relay wrote:
> From: Manojkiran Eda <manojkiran.eda@gmail.com>
>=20
> Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
> ---
> This patch enables the aspeed video engine support in ASPEED BMC for
> IBM System1. It is crucial for facilitating the BMC's video capture
> and redirection capabilities, which are integral to remote management
> and KVM (Keyboard-Video-Mouse) over IP functionality.

Can you please put this in the body of the commit message rather than
in a comment?

Commit messages need a body and not just a subject.

Cheers,

Andrew


