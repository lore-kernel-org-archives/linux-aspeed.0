Return-Path: <linux-aspeed+bounces-3258-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDB9D148A0
	for <linux-aspeed@archiver.kernel.org>; Thu,  8 Jan 2026 05:30:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmtlS71Vfz2yG3;
	Thu, 08 Jan 2026 16:30:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767850212;
	cv=none; b=SxYKqO0k1JiZWkGhCSOlc4BOF1pUwp8nlOf2UayaM5r6z4NXRzXLqnqhUX1ITJ9hU1C3x8+4PH5K8CBY7bQLQ6o7NtOR1OekfqMHuwk44E0DI5ybUU9hA251fkvHBjuLHHY3iU+zR2WxARE+ic8o2VmIfvU+a+hgvVA0vz1YzY9HATKgAQ3+8KKsFwV6NpuuiHDZvTdHRTEDDQsIRuvu2RXogERCrVUuiueZ98U46WW+xh1VRFMXPmy/paZVWcDHAwA1OMxosJzFsHlDbNfLmNuFTvbuSYieIPNLOeONRNl4Pd7sP1JRKElcfp/bkitGHRx+M5CwTIfh7ZeyTH4THA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767850212; c=relaxed/relaxed;
	bh=MfTEXcf5zciGZot0fekZJidEbYo8hYFDlzJ4aD4mgVc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OCYzGcW9/hqqMb4QKXTDSvxHP4XAj8L7XYNogy3N3Ykq/265rXunal/dlCcVf/3ANqLx/B3LztBc29aQlhMuBRJgBfSkJt2L06jFABuL19OF4TtJjVpwX158cHMFR1M0ckswLEv/5wLH0DHDyB5VGD9bA3obBWkf7sBQVGfXamddMPf5pwUWNoxJbpGCweVNmUGCsS4ah9IvK4PvbW/v511OMcAihy0QLGl8OnllMjBQxDTpdOgS8lZOOkTNoxgreQ2xUUlR3Ju8MCTVeellDVryOg9B7m5yYSzBQCvEQ+OIOGRhbIbzdMKKObDQSkO575QqBfgeYZDkzY273hMaow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Rm5e8stj; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Rm5e8stj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmtlS2Qj0z2yF1
	for <linux-aspeed@lists.ozlabs.org>; Thu, 08 Jan 2026 16:30:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1767850211;
	bh=MfTEXcf5zciGZot0fekZJidEbYo8hYFDlzJ4aD4mgVc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Rm5e8stjXFPtDa9xewdJ1RB82WuVDvStDj2Lopa19weEhxIYhCWkjIDTKHVn0IqE9
	 8VvQgSrSR4bTvuYkBdS3urYWXj3HKZ30DFFl0Tf98STxAAO/9Gh6ywnRYQcUMsvjz1
	 Pwnu6yVxU5Y/10s9bvygwMO1b2wvMfeUCVOUJKf+NiEIekq8gJokbDCH57ZqiXcgkN
	 bRVKnK35RwaK6FljS8jziMgPR7Zc0KiD2Amh3UxFVKnV8F8nWFgwu+8yWffmLthPWZ
	 umyifu0JiDbfyObUG1Sd/Mhy8ySTe8UljQYU5JTR+f7mQWs++Rt+7e/UCLHhBBp/SZ
	 qumSRY1G/5eyA==
Received: from [127.0.1.1] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 218887C834;
	Thu,  8 Jan 2026 13:30:11 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 joel@jms.id.au, Cosmo Chou <chou.cosmo@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 cosmo.chou@quantatw.com
In-Reply-To: <20251219062948.528824-1-chou.cosmo@gmail.com>
References: <20251219062948.528824-1-chou.cosmo@gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: bletchley: Remove try-power-role
 from connectors
Message-Id: <176785021104.871508.750215017284279406.b4-ty@codeconstruct.com.au>
Date: Thu, 08 Jan 2026 16:00:11 +1030
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
X-Mailer: b4 0.14.3

On Fri, 19 Dec 2025 14:29:48 +0800, Cosmo Chou wrote:
> Remove the "try-power-role = sink" property from all USB-C connectors.
> The try mechanism is unnecessary and wastes time during connection.
> Since power-role = "dual" is already configured, standard USB PD
> negotiation is sufficient and more efficient.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


