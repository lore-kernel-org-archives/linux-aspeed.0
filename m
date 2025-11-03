Return-Path: <linux-aspeed+bounces-2719-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BEFCCF9F8
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Nov 2025 15:21:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0Zzb3TPVz2yrm;
	Tue,  4 Nov 2025 02:20:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762183259;
	cv=none; b=QEyR23c948X4w3135ACZp18HDIFt3aJpUNWBsNEmP02EFk8NC69jh+PL5qp67CJxKPyRzoWEp2aZz1UVulRZdS7R/TCqhtoGCUhPSyZS7jfSpvxFFSVvgMdSvbgH8Rf8unE3izfjSbFizzNGPlWhIzdncS4+YlaiQJYHqubimgCOzxwjP2ntSTXRlrBXoi75dWSvdFlSods/Elot/E7gXYb2XfY6O7+a4fC1MBBhbQcOZF7UA3BtqbkbRAxOmPsGjffuxj9k13pzJ97M6bpDIaJa0D6l6Xrf1xQSwS/K3nQfoA9A2BbfT0HFCXX26NzUg4tiE+4MnQK0LJYVg0QNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762183259; c=relaxed/relaxed;
	bh=UU3IMwLVIuqUs9WFksfEbffdOpEdabEos7vPHn21iN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P9fg20dxYzTAQrZWjBEGg4ITLyg35mmSWAaYD8ybLqMEAeW+38r14vUf3mA3/e0HAnemHQMElizTj1yF3wDjtDeekbJ1AOEu2j6UkvzhZZH7XWN2nVdyVMzBq3KVfvEA4g1ETUgnFhOcmodbkFu19AX2RgYvT6G/7a7nEoquXBj7VMPq5IRCU7IV3CLsz/9GsCDpsNcWK6Lb+rfieuB7j76/tAXwmW7fTuQheiM0fKZ9gIxmkuWunq4WSbk2nA1sPZPZQUiqOXXSs2BCMPc06xZduVXhSx0CX9KKFwYNNEXQ7JPXxXRIpc9y6NCx9tnFGOaMPCSrb4WdTLlCtodmKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=dhVtcWNJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com; envelope-from=dlechner@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=dhVtcWNJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com; envelope-from=dlechner@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0ZzY3nxDz2xS9
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Nov 2025 02:20:54 +1100 (AEDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-7c53400935fso2851916a34.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Nov 2025 07:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762183251; x=1762788051; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UU3IMwLVIuqUs9WFksfEbffdOpEdabEos7vPHn21iN0=;
        b=dhVtcWNJP6PlPPfUbwPWCUVnywXkZdcKWVqNAAM2IP4dTcDy8daJZULpC5Sv58qzo8
         V5kbSld4qyJgYgBCehSlZqJS6qg3Q3epY8szHtaTisTIComIsJ6AsKFTJbZhiIEdvDWV
         tFj0nsTmxBJYX+4bvnl6SpcA8WW6d0kmIlcHzMdGt5sFSUaYNqkofjWNaefyAzZvq9RE
         MyD/6Gbfn2enr+g7FpcS9I1na6N68EH0oNq2EIWaXrQjOcA3HnzRr1Pmm6j+tADyVPOO
         lUBuIyvWQDx+kcRVjEEYRkUH9fYEkTSK2DCcGr7q1KBC9lgy8b3B6gl+b5bd0ymrasMn
         Ac5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183251; x=1762788051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UU3IMwLVIuqUs9WFksfEbffdOpEdabEos7vPHn21iN0=;
        b=XcxjQUO0rLJ6G/1XK7l6WEdQrSrNuBwRMicgHAvmIxnNBRAxXVFDKS8YU8T8JdExee
         KzJ+VFg3t79gk97If205e0ZmVXG6x0rQEe6vUW9SkP7/4wkx9obyyeIQpvUR/TDJk4u8
         rb23mfXqL09WBI1vJ+34eJUR0Lr7SZeyASoJoByOax+BImmsHEm8Ik8X+RQ8wzHYrZeS
         hutaOapQlXo55RNdoO37JVWXT6TMsgEHllZFzG+pIw0fvJSics8BmLMgVnrnuMS5EgID
         MXoYpBcPIYnV2kg0P4X01XE0/iQlTpYMrwSZrR2whD/Yab8oOF9gIm+oMKlDLCOrHRQv
         2q5w==
X-Forwarded-Encrypted: i=1; AJvYcCVYzWiqFtXr+Ge4vjsLEEdKH6ab261iM4XUbOKfMud+THhXTHnYOrt7/rXEWzprA4DbLZdOq9vLlcXqUEc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwzmQJuL/ESWg+z54H9+wr3J4ZL10f/OWrMHcBpGDgHEaBQhJQo
	YUTiTpvnabhgmwZ4b6QKt2bi/WtJ+PZyyRyf0tWm8KypULAxEWc0U0eTK2E6rAW5y/Y=
X-Gm-Gg: ASbGncs/sx6Xsatu2WGboqygkJ5ppi0+Uh32UgM2ViXBODPob7I0SULzGK43gJPBMYu
	24WRKy6/qjnn/uXH4DopRilESp/2N4xIVH9XvBv5eDNzVTO1sPUdnhdAcg1nGYE0azLEk+a0nXp
	OLmKGbWphzo2Iz1KNpUT/85GeziYA37Ox0VRaqyMKcWxlB/F6QRMb7bPlC6ikCKZ3XJgfgbu62Z
	NcJcSACBvxV7hHgnxhBVY3+tduNGXZIiujn2HLfgeQSLfheUO1VYlNYWFN2WofsGvAAljMIXGzV
	rbxQmYcGAFS8qEPMDZakzvhw0cJvKzLyGX7EWQGdwYGqvYDIJbFCxxQx0qyDvSwP9uaQH1KGWuv
	xtOIRXgHs2ggy4tZo7Ws0iBI3px9TwNnmGwM8ttI++x72PETVeIpyUvBWfYp/qMBe24KGwI3/82
	pbGWiedlW3wEICvcSgN/T+SC8ZIafBZVUPScm11hLNyFjTUpefeq+te0y38csU
X-Google-Smtp-Source: AGHT+IEI7oaPwbMLZyrFhJm3x/2HChGggXyz1ZeRNUlqpKNsCrcEcUIruRtbDhBeLo27AIpbulOZpA==
X-Received: by 2002:a05:6830:67e3:b0:7c5:3bbb:9ba6 with SMTP id 46e09a7af769-7c68c82fecamr8720707a34.4.1762183250808;
        Mon, 03 Nov 2025 07:20:50 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:37c9:fd3e:34ae:9253? ([2600:8803:e7e4:500:37c9:fd3e:34ae:9253])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6c2448c9bsm208886a34.3.2025.11.03.07.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:20:49 -0800 (PST)
Message-ID: <3d2fde56-d82e-40c2-9d0b-2888160a642b@baylibre.com>
Date: Mon, 3 Nov 2025 09:20:48 -0600
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: aspeed: Add AST2700 ADC support
To: Billy Tsai <billy_tsai@aspeedtech.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251103105217.1764355-1-billy_tsai@aspeedtech.com>
 <20251103105217.1764355-2-billy_tsai@aspeedtech.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251103105217.1764355-2-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 4:52 AM, Billy Tsai wrote:
> This patch adds support for the ADCs found on the Aspeed AST2700 SoC,
> which includes two instances: "ast2700-adc0" and "ast2700-adc1". While
> they are functionally similar to those on AST2600, the OTP trimming data
> is located at the same offset (0x820), but uses different bitfields.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


