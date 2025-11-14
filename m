Return-Path: <linux-aspeed+bounces-2907-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB7BCD4F49
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Nov 2025 04:30:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d741c5X2Rz2yvv;
	Fri, 14 Nov 2025 15:30:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763094612;
	cv=none; b=lHBdZS5HZAAsmiXHPQT1Tta/Rn5pXZo85M3zK3xN+ouj43HoXwlHUWNUMJn04HoPQ5Y7ugFriWtWwqh1A0TfBE+7/UolZu9CCkb0Q+0U2j58AE/Z+pQ2DNlaM6WSCcVuCBRIDL2a4acFWslHQhQPtXDbCzUwhGyZtGs/iI64PifukI20/x4hYVa9V0/EhmXrhT85fDhOtUXansi8+PdBrhsJjmWRi0Ogoh+Yfa2IbSeknupcauvLimUGaqbPHX3cSbP6JIKsY83H8E8sqd/XXt6UQlDcW5l0jKvT96sxkhhMCSrhbhUnmGqJPOCWL7LHZ4G42O2X1KICX0D8BXlvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763094612; c=relaxed/relaxed;
	bh=Asl2n77HU3heubUqSeGFUaLgvo8IPQ436F0WxE2PGX0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SQJDpmUf23XHcfXNXzyJ8qE3oaQkqeTm1BLfOdXB6/yLXT+GwGKh/EzGam3SPcOB0ZpGru3oBqDfNgdX1yoekWtk2u4loHRM/FhlUwAk/obKmm+1tv3h0h2Aurd9uMwb1AABo6AON16oy4/Zqvajug9FnOVZsTuLzOIrfcwTVmnbUgQgoX+81UBLzlHxZjE3dvwfvp9zFfzlZBw5Xw82qJe7K+IPdxIyg11VnHj9iuSjQ2OjxVTGl++ygmpBORAyLjmOF2FKj1BUjJ1OBz8mSxle4TO/wIXPd/MwPkqaZXctuqpZG9Z+Qmfndh1N3O+iy2IOae6zR62n3pmBIo8iKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=QGP5Yb12; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=QGP5Yb12;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d741c2ph1z2yvX
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Nov 2025 15:30:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1763094611;
	bh=Asl2n77HU3heubUqSeGFUaLgvo8IPQ436F0WxE2PGX0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QGP5Yb12xJXFWdCyPoGzgklbAoRrvIoeVYaYzwPUwi/V8gT/P5FinrJrjwHjkbOWy
	 p4FYmlSlNYNesjTZv5fQCYPAeiOLm2DNRu43/KuC87rM7+qUrXKkvRitIwPTm/PZ+W
	 SCpvrIHopL8h75j8jx4QZHqb22sftUNvwBSD1KvP2yo3BKam7OG99V32+ahF0Zh5ue
	 x+inRUwUd6T70FtkiQjTFKzmeQh6W96EHdRsSvfqW6o2s3/8u/ofdsBOM0b/VEjLVr
	 12pgtYVKulZNx7duVVG0sSTG+kVo00wauh4v3XyM2hMNxLv1Dsc6O+zIR9k9+4FJI3
	 eVm1DjAZbHmdg==
Received: from [192.168.68.115] (unknown [180.150.112.244])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5BE61783DF;
	Fri, 14 Nov 2025 12:30:11 +0800 (AWST)
Message-ID: <a4d3dc7e6186f41f5bae9135574c21411826e554.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 0/2] ARM: dts: aspeed: Add Device Tree for Facebook
 Anacapa BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Shen <sjg168@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, 	linux-kernel@vger.kernel.org,
 peter.shen@amd.com, Krzysztof Kozlowski	 <krzk@kernel.org>
Date: Fri, 14 Nov 2025 15:00:11 +1030
In-Reply-To: <20251112211248.3711889-1-sjg168@gmail.com>
References: <20251112211248.3711889-1-sjg168@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
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

On Thu, 2025-11-13 at 05:12 +0800, Peter Shen wrote:
> This patch series adds the device tree binding and the initial device tre=
e
> source file for the Facebook Anacapa BMC, which utilizes the Aspeed AST26=
00
> SoC.
>=20
> The patches configure the necessary platform peripherals and aliases for
> OpenBMC usage.
>=20
> ---
> Changes in v6:
> - Rebased onto the latest upstream kernel (v6.18-rc5+) to minimize potent=
ial merge conflicts.
> - Restarted the patch series submission as a **NEW THREAD** to fix the in=
correct threading/In-Reply-To usage in v5, as advised by the maintainer.
> - The email sender address (From:) is now corrected to fully match the Si=
gned-off-by: and Author: address (sjg168@gmail.com), fixing the DCO mismatc=
h issue reported against v3/v4.
> - Corrected all previous style issues: fixed block comment styles, line l=
ength issues, and removed un-documented/unused device tree nodes (amd,helio=
s_cpld and eeprom@53).

I recommend using b4 to manage your patch series. Using `b4 send`
automatically tracks your series submission and adds links to prior
versions to your cover letter. This makes it easier for us to track
down feedback and changes.

Andrew

