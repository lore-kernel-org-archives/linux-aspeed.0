Return-Path: <linux-aspeed+bounces-1187-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0E9C3ABBE
	for <linux-aspeed@archiver.kernel.org>; Wed,  7 May 2025 03:22:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsgYK46QGz2ydN;
	Wed,  7 May 2025 13:22:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746588133;
	cv=none; b=kSpZMPf8oqYiVsOAhyy/b2+5J0Qg9mE1Z5ygLgAp4QLPyhsluN9Iss7a4O3fEjccnjznBSzno9ii41qKT/BuviXL+5xj9FxQ+zWe0amaF/OeMryGZuAs8hzyMIb4KBI4fKGO1madahMeXWvm9SkuIhUuxwIeq+q3v0AnLDTBF3h34FjLk3Bco0AuKf1y7g3sGZo4UpnV5a5O6eab1YW8706bXUOioaJUAScoCuGFHmRC2JN5wch+5+lstcVMbhTOZLpoKKCSqnbYvvl4rUv059oeaMFAo9Txt9KaCp1nbqWbM9edX/UfLKFoMjVkYMmcnBP5NX0Kig+9+cuRaunHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746588133; c=relaxed/relaxed;
	bh=WxnIZWGjyW8z4p9AhSnJJsn8ZjAdBNM5VL2W6LDw1c0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DGYkDxp2vkU1wEIyRTFxEiMpEyFSzOB0BNNyMJiX2t5txZafBOqlq9ab/5xD+3SeujDIjaOKPpbUxeYJvEEdYdDK2maGmWiF5q9dc+Utz+isBKbMnN0FRaGSEET6lnoWzfN0ySi51Teer1tOMAQ1OVLGfBKYdnMEGiPoquFEoL5YvAu0r/EE5O+jDAOtRLWjNmg3hZyTzDve/GIJBp7TYqNCXd9qUqT/qn3ljrhlnFFY7hX0ys+AqDCn33WkBGfLSPkdOWQuN0MqPJSO+b1p/yph952aCiWAAHQ/S2bikSqm8oVQ2YFcueLLjhqgulomeYz0oVLFY7HHtgaCHmMfSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bCR+8fc3; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bCR+8fc3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZsgYK0nQsz2yGx;
	Wed,  7 May 2025 13:22:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1746588132;
	bh=WxnIZWGjyW8z4p9AhSnJJsn8ZjAdBNM5VL2W6LDw1c0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bCR+8fc3LtDcSawxO4X6KapprEaFUHlDopKZmFaplYY0hg9qY2ZHxxAV725dw6TZI
	 vMDQ4I5qCYW6aZB4ClA6mBPGWTAzsDb1q1Thuz7JM2NEN/d3IuDPcTQLqgOX/JwN49
	 KHoX9w693tqIC2Wx8pBJhr+8PskzFyOU7AHb//tDxrGce2vfyWslb8hUjjTgbuA7VR
	 Q5OEngX/ctCaryV+qVyYxXLfGBO3HzAYro10sfoquGFdPUUuZPvdQI5ai05jbgyxJM
	 fT8bxI8lm3R4gU+9Se9xj6dc4oLjeMt/vfVhuQ2ToHwniIaYo/sUJ108EIsmeyRJEA
	 xje1L/94ngvGg==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 324D864473;
	Wed,  7 May 2025 11:22:10 +0800 (AWST)
Message-ID: <5acf9c0afc764931f3e9e70c4085beeb95b9652d.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert
 aspeed,ast2400-i2c-ic to DT schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org
Date: Wed, 07 May 2025 12:52:09 +0930
In-Reply-To: <20250505144605.1287121-1-robh@kernel.org>
References: <20250505144605.1287121-1-robh@kernel.org>
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
Precedence: list
MIME-Version: 1.0

On Mon, 2025-05-05 at 09:46 -0500, Rob Herring (Arm) wrote:
> Convert the Aspeed I2C interrupt controller binding to schema format.
>=20
> Drop the "#address-cells" and "#size-cells" as they are unused and
> incorrect anyways.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

