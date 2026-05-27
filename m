Return-Path: <linux-aspeed+bounces-4133-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B27FCD5BD2
	for <linux-aspeed@archiver.kernel.org>; Wed, 27 May 2026 02:30:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQDBQ6NY2z2yTH;
	Wed, 27 May 2026 12:30:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779849054;
	cv=none; b=YrVPAruxq1LT97QmjdG9/Ysnkok6/TE1musUb13dk6V0kHcuEGYJUEh1l/j+MYHAbdskhzQv//0J0xXv4wRHAO7hffKg/YWbRimZ7PSCKPPUhFopXhFORAHnFTCe7UjfqHp5If83rqGzjDGFrxlCi1fHYYu6H89lyga8q8eohSGP6PILNow0ocX2bCUc4ticDb4pssDOXnpS47f5jFfZlvOdZiqQxUHqZgH9MIxUvq6Txre3b1Sa2tPBKEGE+StsqNUhUhIBK1VCTpnC6cfEERvIokwFOMx4F4gdnh/7568/s5Yj3QcOahi6aMEhpgQZHG6Vr2S5XcUKnZEyfrPF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779849054; c=relaxed/relaxed;
	bh=lpr9xFXmjkNhPC9HzvxzWnPCgQ3zrHpMC0tkqgto9vg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=biDWMZ8pUmWWHhEZof11bCe9l1PMYo+837xbYYTti/Jp7Ee/gUywTtJGzuaA3CJlrI84uj6wDPcVU+JHTbIOcMJpOObgAWPlx48fIowgA134BoQoifGkFxaRIYxvDqWhL8ghP+t4CS7teFO/h6u2ySSdQnPZZI9Jn/BBA6dJoz6eqEPXYhrzo4bS5sZguTLJjvVHi2aF3VPFq/PiPG5gvkuscP1sNPO8DxNzQF0rq6ar6SOkizzuekhJGXBUlCg33E6lO+zHmYRjGT3FClGtqqNNd80X77WVwpE8JcoCkr9CvbfPnAUEIG3cvl8E9KetWw09qn3f+p0mrtv4qBE7lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=iaw4GdLk; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=iaw4GdLk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQDBQ1GCrz2xS2
	for <linux-aspeed@lists.ozlabs.org>; Wed, 27 May 2026 12:30:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779849053;
	bh=lpr9xFXmjkNhPC9HzvxzWnPCgQ3zrHpMC0tkqgto9vg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iaw4GdLkKPvJimvx0rRGPb1FU4Og6DZcEVWiEFk3C4ea1qo/69d9KV7zgPPlYFrLg
	 3qCpRwECTDFtqxyNvqiY7CeIS52rjWDyz9tJ9seSNbP/wq958BRXok6rUq6uf1s9as
	 L3uoqUFb3GDz3UezCLDC8sZIKkCBAcAoYrHqcfVia4ka+Co4wfiiKsHAEqL8k+H4iF
	 Xp61ckQRtn+Bjw5ncWT5sE1ASUS7X1R+3Uq1dhraKFoSXYQmSbIE+1zy0LgOBRLAG0
	 T0r/q7F647PkQZtfsOFXuq3VexiER0SMscedY8dhYRd0CzAQ/rqbft/4yCNvaa4aPO
	 TIjAj6saULZ5Q==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 00261607F4;
	Wed, 27 May 2026 10:30:52 +0800 (AWST)
Message-ID: <a0a62d6bcc1d1253a38fa166f4b121caf0463345.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/2] Add Meta Rainiera6 BMC support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Neil Cheng <neilcheng0417@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, 	conor+dt@kernel.org, joel@jms.id.au,
 geert+renesas@glider.be, 	magnus.damm@gmail.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Date: Wed, 27 May 2026 12:00:52 +0930
In-Reply-To: <cover.1779157117.git.neilcheng0417@gmail.com>
References: <cover.1779088499.git.neilcheng0417@gmail.com>
	 <cover.1779157117.git.neilcheng0417@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

On Tue, 2026-05-19 at 10:38 +0800, Neil Cheng wrote:
> Add initial device tree support for the Meta Rainiera6 platform.
>=20
> Changes in v2:
>=20
> - reorder adc0/adc1 properties
> - add Acked-by from Conor Dooley
>=20
> This series adds:
> - Meta Rainiera6 compatible entry
> - Rainiera6 BMC DTS
>=20
> The DTS has been validated with:
> - make dtbs
> - make dt_binding_check
> - make CHECK_DTBS=3Dy
>=20
> Neil Cheng (2):
> =C2=A0 dt-bindings: arm: aspeed: Add Meta Rainiera6 board
> =C2=A0 ARM: dts: aspeed: rainiera6: Add Meta Rainiera6 BMC
>=20
> =C2=A0.../bindings/arm/aspeed/aspeed.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0.../aspeed/aspeed-bmc-facebook-rainiera6.dts=C2=A0 | 1012 +++++++++=
++++++++
> =C2=A03 files changed, 1014 insertions(+)
> =C2=A0create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-rai=
niera6.dts

Applied to aspeed/arm/dt in the BMC tree.

Thanks,

Andrew

