Return-Path: <linux-aspeed+bounces-4135-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF97BCD5BDE
	for <linux-aspeed@archiver.kernel.org>; Wed, 27 May 2026 03:06:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQDyy3xnSz2yTH;
	Wed, 27 May 2026 13:06:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779851162;
	cv=none; b=RQCVILHcTamOpAdKrNk+e8wpkrTP7x71hdVOYAJMVMa3XiRQCtCS/GAgsaVIIsaiL2CA2NgchIaWeTYVHYFxHdUovMA/e9B9KtoNyQ/UkDk4bhPxdR55ntFA6/05Ampop1NHQ3u6DcYlSapYk8yVDzyVKKA1hiGrpDLwuZBzzK2ozubcjOTbFnQ7hnNJXrVmsM4Tj52tJbNIpBRTgQ9SzpeqljN6LYign6NkAv2m1/p1L0LrkWgUdyYP+zttEUnlP+qsRllqweGKeGswAbMorqkSYmptVsPIS038bRcmD5wq9tPTAc0RnE9eCwQVdiG33LXMpq2jxVksTT40eoMAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779851162; c=relaxed/relaxed;
	bh=IF4geJPizXwz+Vvc9PhYKe2Due5htIQsfI6rr6h/nk0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZBtMa9yK/japFjcP1KT3wJMrWDgXGBlCK4FQm17XOv+fYhihKVR1bA5XEKbMPvQm7LejwWoEonZWAym1N7WZ/zuoxrFhGkbngzw9VsO/YERL3WQ2I/PGIYubrk20AlHHa9DU/WXwyK0xlOjzA9a7kydxE6WXc+Xpx7A0o09MzBvbUSHRPPY9j2plH60XNLoG93t5iA2t48kf/SXf1b0Tpn4DdCwLTZb35maNfbmv/zpmAN7XAEt52PdVM/5PCw+MNZznKYoh6VTmPna+EzhgEvjUSoUPc9gF4T5p3wNqei/l+UiStCy8QjVgP0Nyk871ksx8D2u8MtOupl8oY5Bn7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=BoixamT2; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=BoixamT2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQDyx2THfz2xtC
	for <linux-aspeed@lists.ozlabs.org>; Wed, 27 May 2026 13:06:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779851160;
	bh=IF4geJPizXwz+Vvc9PhYKe2Due5htIQsfI6rr6h/nk0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BoixamT2E5JqxH274O4RVLgy39fLf2XmDHEcudXvmtDQCi8slpm/b+D6rdTV/89Zq
	 6TSnbbWucDOJC/tbGPUyBQRRRW+6vVs28L481iyGUQHktTxj33K0TnPkTFbHmr5mNL
	 F1b3t5ovLfeqmlKOfnJE4XfVfgjIzg7r/TnGHweKAviWNKTMxzCwMV2zswHHNS02Gf
	 KEUeOGYHfXSLLCxNgt2ahuROfzsurvj4QWJ7evOFOdR7q83MaImp71bajepnikGgl8
	 6D88/o6hTr+RmQI7T9YhbdT3sIjkGVilR3lryT6IAvIMQRQY/xlMS5AjNifliC/wzs
	 DxCIhhjJ7c4VQ==
Received: from [127.0.1.1] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3DD696001B;
	Wed, 27 May 2026 11:06:00 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Mike Hsieh <mike.quanta.115@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Mike Hsieh <mike_hsieh@quantatw.com>
In-Reply-To: <20260522-clemente-dts-remove-iob-nic-tmp421-v1-1-ee2509a71502@gmail.com>
References: <20260522-clemente-dts-remove-iob-nic-tmp421-v1-1-ee2509a71502@gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: clemente: Remove IOB NIC TMP421
 nodes
Message-Id: <177985116014.389804.14182803385657639805.b4-ty@b4>
Date: Wed, 27 May 2026 12:36:00 +0930
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 22 May 2026 18:07:59 +0800, Mike Hsieh wrote:
> Remove the TMP421 sensor entry from the DTS, as it is no longer the
> primary telemetry source.
> 
> Accessing the CX8 NIC via I2C while it is powered off causes voltage
> leakage on the bus, leading to EEPROM corruption on shared I2C devices.
> Removing this node prevents the BMC from initiating traffic to the NIC
> during initialization, protecting the integrity of the shared bus.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


