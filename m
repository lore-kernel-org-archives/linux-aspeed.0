Return-Path: <linux-aspeed+bounces-2983-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE00CFD313
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Nov 2025 04:53:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dFD3d2Tcvz2yvN;
	Mon, 24 Nov 2025 15:53:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763959997;
	cv=none; b=hrR/ebh5lP88uptXmkNyO0fP+CTCxzBsB4/VI0HhRWVKln/HaaFWvPoGelgPmVBE0QqLKIr5aeW7GsiDRp+7gf21mys7K+S1LDUKkg6dCft1MYSj6xSNWgm58mYKwtaKOSJFmMZNmp2wSFkoWOH1goW9URWNb4z/3pkMKIxy21X9ZxkSl5vfH0T956aR65SRCcEIXBhzQhvmP5abJNcp5LQnMmEgpl/5tpFH3kLTyvbs6rnr9/9qr3dMhk96bPXldE8l1bje81OGzVRt798RSDvxZOdz+pzpgvWtQ9Voc5UafXtdzNsAHITaptLx0MVHPwWKQuOjJbD8FHI6s63bgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763959997; c=relaxed/relaxed;
	bh=9I9iLfORj0tnccwQ6JBu3v4qfLj7ltvuhaVoT+aRCJY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PQo7d4ULhJKQYcOZPovbXTiQwWpVpz4b23OgKm6cOeO7mhV28+zqVKb/YDnWdHo2dhqegcMJ5ycH3tIH70D2GQyrqdVPbmE8Tins0KL0+Nt1mY8DD8bsfJFCjVTNxwYhnCZMICTePq0XwTF20knnWwXGDmbPxhHWWbTc7Bp8O0/Wpd3WlTO31IklQDSITEbT6EIW9kgZmnDS0UraHmiGASgSXy84cjwGOZb8etSWGMqn1AwlqYrZQz0XinJgaz2k11+NE4CIzxoZPuXgIDLR4Br+oZQnwuusm3tX+pzerEnginDFBlRqIfxaFveUNWObrwBT7s7KxgC5attST6w/UQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XPlfbWiq; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XPlfbWiq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dFD3c4GTNz2xQs
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Nov 2025 15:53:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1763959995;
	bh=9I9iLfORj0tnccwQ6JBu3v4qfLj7ltvuhaVoT+aRCJY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XPlfbWiqWeeK8tagGbtC5l+y33JIHb4VYe96JR3a2f1W8XzsROquq/UhdHch4VOx9
	 l5Em4ycrOn7lR30IydhrxAvOk5zkjhyeMjsYzVVTyaSKjKuvg5ouV6cUAXmFwKaMaW
	 m0SVoEqVo+oG/cVx2WbpspzcClZDx9WyB047HHqpNrEqKhXy8WdxKN1GA9sn+EgZ9W
	 XgtX8Mz2VvsaNRTS1gYNwIdwuX6JAnEoqmwhHEZ0abMMJKCNRkxutlVtqWfMZDtg5j
	 aguJYtHYJax89EtbDNd5mQ586yEunWEA+r7tlRcew09XLJjPPDFPbkcJ+S+PHZd2gY
	 UUgj93nr2tm9A==
Received: from [192.168.68.115] (unknown [180.150.112.38])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4FECA64DF5;
	Mon, 24 Nov 2025 12:53:15 +0800 (AWST)
Message-ID: <c56ef6e76858c7df19ec43a3a18ccf79ff3cc489.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/4] Revise Meta Yosemite5 devicetree
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Amithash
 Prasasd	 <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, Ken
 Chen	 <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>
Date: Mon, 24 Nov 2025 15:23:14 +1030
In-Reply-To: <20251120-yv5_revise_dts-v2-0-4d7de701c5be@gmail.com>
References: <20251120-yv5_revise_dts-v2-0-4d7de701c5be@gmail.com>
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

Hi Kevin,

On Thu, 2025-11-20 at 13:25 +0800, Kevin Tung wrote:
> Summary:
> Revise linux device tree entry related to Meta (Facebook) Yosemite5.
>=20
> Changes in v2:
> - Add ipmb node for OCP debug card
> - Link to v1: https://lore.kernel.org/r/20251118-yv5_revise_dts-v1-0-fcd6=
b44b4497@gmail.com
>=20
> Changes in v1:
> - Increase i2c4/i2c12 bus speed to 400 kHz
> - Update sensor configuration
> - Rename sgpio P0_I3C_APML_ALERT_L

Sorry, I replied with comments on v1 before I saw v2.

Can you please resolve the discussions on v1 and send a follow-up
series if necessary?

Andrew

