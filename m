Return-Path: <linux-aspeed+bounces-2375-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4315BCCA470
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Oct 2025 14:56:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccJ0b3yxRz3cf7;
	Thu,  2 Oct 2025 00:56:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759330591;
	cv=none; b=F43FMDH5y0KRzCmo8EPmfIebomb7SvsK6k5lefObBL8zM8ViicZ3sdwsTH9Kw8aggrEBumV0mZgnCAndeg1zN/EnYQjO2UQvqJKxPCQRz7o9nOatCIvwBNEh2oamteH2wz9FhCa6NaCv/Nx5Z2Mw0E6W5fpPJNaMTzX/ohWx31gLUfCPPV9LPavSu/JAUAH96EERPx86SpLgU/Gb6J1rDas+wcqLuzyL9UCFb2CKNAErVIw4cz4mjBd9Oe9L98waCXdKYKzg/lSMV+BxorV2V9tVE+RE//Zyf6XnoqXZKcfnptMco8fUVBDK/nDbImTkAY65LYxM2mYpUdW2KMGchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759330591; c=relaxed/relaxed;
	bh=vMaRMjae5qhJ6T8LZr9SwTJXOKHeU5QOS0jWZvlSGc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1v7XQmOFBF9dchEe/J3h0jrmzsaXzKscpua3Nw4RBklGhSKYJ0tNo3mITmy8uqO+/ykzBkn3SLnJIk/h/g6TAJv9vczw1OVhdUH3x4A4883v5tJyPiiPYNZr4QniraVgWcZ0TjiRPURsDV+f02MIXUnvwutPxc8biwMrxKPnsmbsyg7LFE5AFw4JSG0vUDvjS5jZEbZnAPEzf0dcsgYCkSRL7etNZ1XFVivV4EtxuT2yVwcrq+aucmUmPyn6uu0aRUJwPcYltbLLagTpBeTM4As50p8UZ62IUwA5iaPJdiHFfxdaYy2xzIY95m7bahvH98fuRRwbyx9Vd/HXpLcEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HpW+HMli; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HpW+HMli;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccJ0Y52TCz3cdn
	for <linux-aspeed@lists.ozlabs.org>; Thu,  2 Oct 2025 00:56:28 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-78127433a32so3934707b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 01 Oct 2025 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759330584; x=1759935384; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vMaRMjae5qhJ6T8LZr9SwTJXOKHeU5QOS0jWZvlSGc0=;
        b=HpW+HMliUAvu9LuIkZQQmKLi7SHgkHs9wbJa/GfguHqIKnhid2qYL/2Npkx7w1Efud
         +8Oyw+H4rH4cfpbo/5BERDk9bpTk1uHf9XB9QO1+1m+G4ymr1ICw5EtKkf1DYB1URTNQ
         /XDzrAX05JUBHJP6bQvxiG70WdlBkh+Niegy/pfBgCBiIzE0kXN+uvCWDnumvA9rRzD6
         UsKf8nxo1gyDRrCepDY1osMkuebop2DZWeIE+JMuMMFrrUuEtXCXIFciW500tuygJfwS
         FRyr+JtHWRluqrp30fDDrDqx6xkiL9gudvZ9R3DTZlru+8yuiiVG0Cg0NNokTF1BprKw
         XxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759330584; x=1759935384;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMaRMjae5qhJ6T8LZr9SwTJXOKHeU5QOS0jWZvlSGc0=;
        b=b1XilGzNE5uZmvKZ33YqFpSgf3xe0qJcbUNjgWvW8aftzvgpLfB8P57Y92lQTZSajM
         Fomt833nUsXJqgsEGCJfcUppaaRkn3Ir2LeemUeJxdOHn6JGotIBLjmYPZjoEf608fYh
         5OQPt9oXdxJ8oHhgcXjJ1HaQIEJxJEXk5tbw2z93v2Fe3Dxoq5fPZhCK2gSv7Puq5jIy
         x7Y3yV+p/5LlrVnNEdsRLmMyceDFp4PUXb8+kh5f2yzgry8P8LbBJjtSm3T0M2U+W2v9
         AthU5iFLuW+aTou0KUs3GmuS3RzD2KpLXvaxDnjA957Yxp2VUg51jWaefmefsW+uFcVR
         sCYw==
X-Forwarded-Encrypted: i=1; AJvYcCVuR8onxLz5MBpyP1h1teBrxNE1AfbVnWOMJXzuXJt7OhPnI3mBVFYUenpv8+3NtrqbJCQ8jSmmz+aExL0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwbinluMgrcvOYh+o6zadWI+iNVCWrGMbcBW5/ML+zfV2CKN1FG
	n2sgrSNh6R2TR0eEW9S7QWvkXC6BNsRjaCopj4IzDNjVEJUNggGoJyoY
X-Gm-Gg: ASbGnctXm/mt5oeLHfsItSN5wnv97LGM92lxwa16DlYhyYjJYFknVJ8Espv78nE+kSg
	rjLWvtwYXj0y1+tSFXBAAnFWAxlE8f0cq5IdmII/qkz4C6Fv6SwDTZ9cAKQLM3DQ2lQhq7vcERD
	uvyKVU6RkwaonbEcWUNt7eodxS4uSEXTv8Ewbe4037KfuGVaPj1+M+avWnldpgoXN5vD5UUr2Ez
	IQpIr/tUFlJ9Iezp63Fpj8Fl5GnQnKXyRzFGYy8hjBA+XlblYt0dKAvE9u/Z8XD7ag8Um6F9uqR
	GrsJlb6zeUdTrT6aZxOVXJRD7IYNu24XkqM4Fkfc4rI0ujlpuU0AuXNL4zfHqc/PYtL5351JW9f
	kX9V4xeXMQfbAYW9TLkj49Ga8c6hz82uLm+tMYDYWO3qy2WjmAr2AE68yHGwtbkLl8FklEZir+t
	1xqIOsfPbmAdnnPogMJ5o=
X-Google-Smtp-Source: AGHT+IHNGQLvotx2qaUZNh8cndj8yxi/+YPCSljuENQkge2S0/2QPiWneDeKuPJFHif4je6sXsDnzA==
X-Received: by 2002:a17:90b:3511:b0:32e:51dd:46dd with SMTP id 98e67ed59e1d1-339a6e97a92mr5001609a91.16.1759330584328;
        Wed, 01 Oct 2025 07:56:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399cd8013dsm2418350a91.4.2025.10.01.07.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 07:56:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b0632c19-1b98-46fe-add8-d2926fd296ea@roeck-us.net>
Date: Wed, 1 Oct 2025 07:56:20 -0700
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
Subject: Re: [PATCH v7 RESEND 4/7] dt-bindings: hwmon: Move max31785
 compatibles to max31790 document
To: Eddie James <eajames@linux.ibm.com>, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 chanh@os.amperecomputing.com, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org
References: <20251001144441.310950-1-eajames@linux.ibm.com>
 <20251001144441.310950-5-eajames@linux.ibm.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251001144441.310950-5-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/25 07:44, Eddie James wrote:
> The binding for the max31785 is the same as the max31790, so just add
> some compatible strings for the max31785 chip.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

I'll pick this and the next patch of the series after the commit window closes.

Guenter


