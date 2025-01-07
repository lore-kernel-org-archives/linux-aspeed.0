Return-Path: <linux-aspeed+bounces-319-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8A2E77197
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 05:53:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YS0bQ15DGz3bSm;
	Tue,  7 Jan 2025 16:53:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736229218;
	cv=none; b=TtV16RrQihViEzCXc+J2JjnhdvlALbwUrxINAuC+Rs5+3lUs62/NJjLx5DBHRVwl/GRWPoQu1Rf+b0cBsScIjWU6GnFDweTPRUBpN0pzuyq3nvDow1OALhcM8+1WqMbvhUqM7QyfKyHNzYz2NwtoEUXXzHRiwLycLKLFg3NoBiAMmh+Pkk5GalfoNPXJ7hGiASXCXFFkdrtkdMLBaLkWJ9inFFIelZFyIkrRlbJDTKwIxD/dM8pcZos5u8bKRSB8T1eOoaIYrtyaLZLAxdF5XFTlfURjjyXFreUQRYpF4F+YxWoDd+WjBDVEeoNIru5nIaLrZ7J04y4E+dvoJguRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736229218; c=relaxed/relaxed;
	bh=d7GzDGEIhCY1GK+byjPJdhkSL4A03CBJlx1sryt4hPo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jd7I5PQYNM1Ebg7L051mJbjaEXx5K0KDaFB3yCP5OD3zm1px/H+qdHN9wPJc+ZKHrfH3YWVNaLcpS80JrNztSSEeCY528jh0NXAknecMAgBhPglt/z1+hvDAhVbx8Tm5umhMy69paS5EcNk0nN6FdBQyZ/ooRrU8spFLa7iDODKmpAIkHwO/EqMjqXqNYb84bpE0fM9Bi+xwzkxIIm/JR0r5nNTzWQGRL7vVn8WAu1LDRA5/Z8kbE29zZABr2/vJ5kmi2ezMM5k20h4E3Ug0dCMyOr7s7Wi+qwlKmgAYTfNCqktaB8g8NDwkgshkpoeqDYZeqanBmTg6abX5EN//ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ZAd0MKTq; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ZAd0MKTq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YS0bL0tNcz3bSb
	for <linux-aspeed@lists.ozlabs.org>; Tue,  7 Jan 2025 16:53:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1736229213;
	bh=d7GzDGEIhCY1GK+byjPJdhkSL4A03CBJlx1sryt4hPo=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=ZAd0MKTqX//BY/sdq4QR1aa6bCpL2f+2d1H7bdthMjEiGRjDZKYXAAaxkbDYkjyIt
	 t/7hbnDF1fryFVB0E0T0Oh3RYRoMdhhul9LVfkOfsuKJLJMqLWkSxGOXtjyPZX6Krs
	 QhsxZ20PtOEB9K3bgkuyWdtOtWdkReA6alRnUwCL2RzQt0NiIxsPTOdVrNC81CZ7Gh
	 cJibHg/zrrw3h+eOs+2mxqYaOe0mjzJQiLJLk4K5p7hTJONu5F6jri3yhJHag8OEPx
	 hHq74gvuPRgJaXlRFSN38Rq6j5qEdvtSvPTpdQHjlbvucGFmFjaVcB9Ymw3FyQAHfR
	 gmbsuyE3ozbMg==
Received: from [127.0.1.1] (203-173-1-122.dyn.iinet.net.au [203.173.1.122])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 33B74706BE;
	Tue,  7 Jan 2025 13:53:31 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 eajames@linux.ibm.com, jdelvare@suse.com, linux@roeck-us.net, 
 corbet@lwn.net, joel@jms.id.au, Delphine_CC_Chiu@Wiwynn.com, 
 broonie@kernel.org, peteryin.openbmc@gmail.com, noahwang.wang@outlook.com, 
 naresh.solanki@9elements.com, lukas@wunner.de, jbrunet@baylibre.com, 
 patrick.rudolph@9elements.com, gregkh@linuxfoundation.org, 
 peterz@infradead.org, pbiel7@gmail.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
 Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20241217173537.192331-5-ninad@linux.ibm.com>
References: <20241217173537.192331-1-ninad@linux.ibm.com>
 <20241217173537.192331-5-ninad@linux.ibm.com>
Subject: Re: [PATCH v4 4/4] ARM: dts: aspeed: system1: Use crps PSU driver
Message-Id: <173622921112.97504.9310903819331925081.b4-ty@codeconstruct.com.au>
Date: Tue, 07 Jan 2025 16:23:31 +1030
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 17 Dec 2024 11:35:35 -0600, Ninad Palsule wrote:
> The system1 uses Intel common redundant (crps185) power supplies so move
> to correct new crps driver.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


