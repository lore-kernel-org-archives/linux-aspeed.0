Return-Path: <linux-aspeed+bounces-1934-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1C7C87FCF
	for <linux-aspeed@archiver.kernel.org>; Fri,  8 Aug 2025 01:46:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4byn210KGcz30WY;
	Fri,  8 Aug 2025 11:46:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754617592;
	cv=none; b=LKgIERTpeqCJOwzUpwiuDpp4rGZ1SDGPMAw5Pg8X1/1VYfwGGVZ5YscfDYhfVnpny2dCTpCYFHdw5s8pjy0cIphf1huVzL8qnQkv0YnOqlFDwE+Buan3bDB2kXSy0Gngh1qOE6BhSJB/iG7hVd/cNmekJuPSl5ShiAObavJ5jd64Ok0Wk2TgmKWCALSKNr1q3iFm6t+MvXNXXqpvoNciS8Q+QdpFvvxOeWyrFl4yn1+ETicxy6Izdmh+D5myAi7gXiXAtJjcvWbSgsIgJHDPr8kcpKWByAWBkKuUQu9eVPM6+/BbXK3ezxCgLLp7rH2JFVQO3aIXCtxvCe6d7OvraA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754617592; c=relaxed/relaxed;
	bh=yVp+q0OXEFKzrgZ3sx/tEBHw0oQFJlRYZK/S98YsvoQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=koL9Zu7lrzOW1WggVDncIkviyt99OYzg34mpRJiEnaA0B9xUvdEOcpaBjFm/VGE6r9WvKwrhJReqVsWMWbFV7bR8DVy8RGHLiln0BIXLqG0KP5adZKHq2tyCmwTKoxQn0ATapWFdULKjYjySxy0RbYVjtuvepQeJ7AylSqGjMPx1NYIG8XnAwnY0anA/WOzGIZjL7P5JR/dw7CUW2aA+r8H8MLURiX70yS4l3nONfBduLg/1nlAnBx8+75zcDuC53F7X5AXVou7I7r2xDRey3zdNDhANwEQrpUsjDCkUbqy11dA5mThSmhiTEFDcmv7dWQLpSy3YT2hHfc5lZ3fz1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=hUqof9Hb; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=hUqof9Hb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4byn202pxfz30Vl
	for <linux-aspeed@lists.ozlabs.org>; Fri,  8 Aug 2025 11:46:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1754617591;
	bh=yVp+q0OXEFKzrgZ3sx/tEBHw0oQFJlRYZK/S98YsvoQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hUqof9HbnGjzHizOMdz7dyj5F//rbpBuUZZzrwVb8zd823QbWdNCY2r0GbjAXV8Q0
	 ByI3u6/6ZvmCtcUTIltp0jeanALrnF5bYC3PHSYtQ8LNm/cRGRD/v0lwe9Plo18U3/
	 PTsElkZRTkzZWwEU6aewBeD4jJqO990eQUKZCkxYv7CepGBFq6KaN6svE2woaEae9g
	 1e6bqZHGQeRgaOSczGvPzVhow3jfDV+flGn0hHo97KicVebuOKBaIUF3ajZ9DlH3qm
	 YQmX4vdiKDzINFtflGxbHekmmAIv/+3mkKDVJS/W+a3np5EIjXa/k1WPzgYytYlCzK
	 PU+viEaUta1bQ==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8A4786AF39;
	Fri,  8 Aug 2025 09:46:30 +0800 (AWST)
Message-ID: <54e07d5e67b2d15810d79bc196e92c8bacabf789.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: mfd: aspeed-lpc: Add missing "clocks"
 property on lpc-snoop node
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Lee Jones <lee@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 08 Aug 2025 11:16:30 +0930
In-Reply-To: <20250807132909.3291770-1-robh@kernel.org>
References: <20250807132909.3291770-1-robh@kernel.org>
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

On Thu, 2025-08-07 at 08:29 -0500, Rob Herring (Arm) wrote:
> The ASpeed lpc-snoop nodes have a "clocks" property which isn't
> documented. It looks like all the LPC child devices have the same clock
> source. Perhaps it is the parent device that should have the clock, but
> it's too late for that. The driver for lpc-snoop requires a clock to be
> present.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks Rob.

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

