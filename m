Return-Path: <linux-aspeed+bounces-3257-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54010D14893
	for <linux-aspeed@archiver.kernel.org>; Thu,  8 Jan 2026 05:22:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmtZp71fCz2yG3;
	Thu, 08 Jan 2026 16:22:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767849762;
	cv=none; b=aJTOZwdA3Ueb8KPMTAUh5qKr1K1LT0pWoT1okHRXibvJbopAAJew5KNpkNfmE1nvW6kruC/Cn4NWF5KpF6NE7e5ct+GCtzPN3NqPdB2mo3zJX6ANxN0JyXMLHuC0KM9TJ304HUeIVxgPoCenFyWcuLoDR6fo3Wpi/p9GcD92ejBNe9mwgFhCr7ir1lFIC3evB18rciarjFTIONmG7vYexJYrLuqBEy4Bb9NkRu0zmQwCDeRcy+i4Cto/utYKWsNKTD8IgtwLIsliJx1Khir/FtIZ0feF9quk0IaqJfklC7xCIhwBlinNsahmuQEW5KY+Wj0NX0XcuD3Rx+9INLi6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767849762; c=relaxed/relaxed;
	bh=hPSe2rlEHvzyi69dJB3VX99Hot44xCw/39GofG4V748=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ec161kuncW9OjDsnxhhOOp9iDCraBNqAEJ08/7Ju8J7JGJ3h+zgw4kSAD83IkMRYDPUbnb882IgicLcgjj/+SkVwE+sZeZoilH4G/IcVY8BhxHX6nE4/D7Go1ENGqwkKWRxLR2k8mu0NMV9mNhsd8QwvKD8jTxWbl1qCqJGLKjFIOSiir+7qsu+P89Ti6Q1qk9AAqSzd61UM5MZlk34XzOX1ktRxMnQ5nQ14UOcukB1IH7Bw3spNJh1xv99PEvudXGFgSSqETmqNG3H3kidL/dyDQ9tE90meLtrTdLBOIhv3t6uuc8hrutzp+RgYKmAWlqsBJMbzjBg3YE1GJDkApw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=R/HdhE2Q; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=R/HdhE2Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmtZp3yHxz2yF1
	for <linux-aspeed@lists.ozlabs.org>; Thu, 08 Jan 2026 16:22:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1767849762;
	bh=hPSe2rlEHvzyi69dJB3VX99Hot44xCw/39GofG4V748=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R/HdhE2Q8L7sSX56r7227YzjCDQjxo4Dhg/bw3c0g4GesSdeGUC22BahmZFuMYpUY
	 +Y8MsANXUSCOj6mQAqangpaW7M1VonBWINZlo9DM0LfpObeA7jI5YSmXMhz1XD+JJX
	 XGL+hobqTpSuS7Y1zuWmaPZEy12TwR/Cj6KqE5spQqnQiM7jQu0XibvW+i4CCloVi/
	 OWxFR13Y8w9g8AZYLsMZMlVLFMKNGLDyCujZxmVi+xC9H5tnobUyKxWYlYc9iX0Dqa
	 ZScipnCTHJz/Uda+MUvBsxnlJyYwDMUUcaAfiHqAjG3eCTq6MILuGNUNPuJDOHn/Re
	 m1mUqlz/0V8Iw==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5BF7C79F8C;
	Thu,  8 Jan 2026 13:22:41 +0800 (AWST)
Message-ID: <4441e66d607fe442e392b8a82c134adced03a5dc.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 5/5] ARM: dts: aspeed: yosemite5: Correct power
 monitor shunt resistor
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Amithash
 Prasasd	 <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, Ken
 Chen	 <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>
Date: Thu, 08 Jan 2026 15:52:40 +1030
In-Reply-To: <20251219-yv5_revise_dts-v3-5-ca1d5a382013@gmail.com>
References: <20251219-yv5_revise_dts-v3-0-ca1d5a382013@gmail.com>
	 <20251219-yv5_revise_dts-v3-5-ca1d5a382013@gmail.com>
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

On Fri, 2025-12-19 at 16:09 +0800, Kevin Tung wrote:
> Correct the shunt resistor value in the DTS with the hardware setting
> to ensure accurate power and current measurements.

Why were the existing values wrong? Why are the new values correct? Can
you please add more information here explaining both concerns?

Andrew

