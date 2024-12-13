Return-Path: <linux-aspeed+bounces-225-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEEBE7717D
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Dec 2024 11:13:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8msl07zxz3bTN;
	Fri, 13 Dec 2024 22:13:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734088394;
	cv=none; b=iSoOFLfooVSmkUIQtupzWY8DJePT5VRs2L1+HOz3PSpjOEdFzMapDGpLLVEvqzJrczTrQpeTQuC7JkKrLT+U9rRrNJ9+ew/KtJM3Uxxa9oqcETcwTXGJmlu0zDiAH1xD4lVFgQRzvU+U8/zWPo2S7ucWoVOzcJp3PbQFC/Y6LEWD0ClLOom73RL60efPU19Xk52JF4xpEBcOPaoDnZrFA8X7RphsC8mnZvIbl2LTXtti7D2U7+Rc7akl3pd5vOO5REWxOwg19TwD+/CKSa9sxl2xYhM3wlygMgiTdRFOPBoXQ0yFzVKQW48x9XN9MC8ij3Mr8uXEB5S1pkUbDNQm/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734088394; c=relaxed/relaxed;
	bh=b+E5hzk9rS5dZ8c/Uf93COABPDOOcFsCZtIif80isDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkV7APqr70Iukfv0TokvaQiMrQaUlKcIy5bHqaGLG6vAL4+yGbmoqknPovtwR+6N0a/8UJENkJ1xhi+4XP2bUcWRgP1zxBEOFino9Hk0V/Z4Q4u7vJWDpqNeZtpX8rGJsMMUPUsNvayKQvrUX3kZshWHz/VaQTXMeN6yOygmH+9DkTRalvojOXPlQkZXXxbCqmV/7kvTI0U6UCoQ4HpM82G5FyI+IhJFIT+TSt09Wap+SwSPtSxnLw/2D1xwqcnitpmsCrt1vuxjG0BHrk49mmIIFJx9PXSQg9yph7gNWdzwHs/Fg1vCfQ/sCiRzDk7xzggAZqXFqFVjhsmdyRIe6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=S/022VEz; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=S/022VEz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8msh3mxGz3bTM
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 22:13:09 +1100 (AEDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-aa69599b4b0so24145966b.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 03:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734088383; x=1734693183; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b+E5hzk9rS5dZ8c/Uf93COABPDOOcFsCZtIif80isDA=;
        b=S/022VEzatjc9+1DGuzb77G6qtAbg8oeLY8Wvm5oIxh3YQ3mBfxO7PtGFrD449n3Xv
         ZD34/kQ2m7VESn28wMYu5sNNDpbVkCSYnFrOo28+bcsz4JGa4sogfjXYpUXPdyI7Fqc0
         5IbcCj+vsgZHBG87GJQ71d71Mm0VvgDDX1vt5OEq7zmswtONsEwX0NZpEfdMp3SvCTSl
         t8HNiwzQFn5EJLRmtkM+GqlGetwjgmFw3sFq5e99bGyxdydt8z5dfeThypow1/vHXn6a
         e6Zou71OuFxWouQEaoBRzS4lp+2b3dLrS65k3/4ibkD+UWX+9oKBgq44H4xv2IgVdagF
         pxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734088383; x=1734693183;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+E5hzk9rS5dZ8c/Uf93COABPDOOcFsCZtIif80isDA=;
        b=vreqeOitS4XtK81c0L0ZSkmWnASwHig9qq2h11nab4a1hOCfGEuyk6Mn29zPeOKun0
         lRrPW8+pPo7cPsdw9uyGFFzDUp5Axci9/8b90/IiDZHovyZTRvSjTEkRRBKZ1vv5wzqZ
         cGe12EFDkhUl4U8cDNvkTDlfMIjQ4DOwosa5Pl1jl6UpeMxOjll+ydInOQfKhgvLfgvY
         qVq/4Jyy9aQ3bCT4Ie+8Bw78kmZtUJyGgqCGhR7yX0me3XFuY4TJoWl654UDQHWRxLNo
         u5J53TUxbTKhasOHy/IC/biCyAwqbyM+zjiLt0aEMw7G5bVqCH1LmxjqH+B9wXYBLUB5
         edNw==
X-Forwarded-Encrypted: i=1; AJvYcCWiNRwjmnO84pfPwg1Y4fQEQJkkXBq9oSrXEZ3PdeXwSUUQqpAyKdXLG8IIqnM9BRuxyBZEUZGjElvcn/4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzcGKonmsKolHQOwnyLn40df0aKEz56Ek7vZNWxw2Fd+uRdRYJs
	RWCCSTg6tN3ShVS/OX0QO96ExuU3rDwMyYm1eqtubnZ4pSeunU9N0vcIDRD7iGI=
X-Gm-Gg: ASbGncth+AkrRMQK8YUGgRpXYndQcJlG4XEM73ZkIFfjIJ1xiC6CyQxkBRkOrg4ppVO
	YEVbDeuFfEYDgzmVpSqtBe9RZAxm1w9rtjx7Y+0tAo9UJK1uX9BE7C3M4TZtjNeV/2kYaxLenRb
	/xzk5Jv5lxxnn4dWSuCH48YOu8PEVkATrYWTOKArApnRN40Exx/YI9nM4rP4QSi67a1eamp85wN
	v1eTHz8q0YaO7dY5z32JTgldklN2DSDzSuiF3xv8uMtV9ZF3LujOElzRw05n+IaDc1/CJ5Xb/JV
X-Google-Smtp-Source: AGHT+IGnmOk3a3BoY8152J6bn0Wf1bM7LihNq7gANhmPoA5y0olGDGsEn/VPMC8xmVYLYbJnqljsBA==
X-Received: by 2002:a17:907:60cb:b0:aa6:6f12:aa45 with SMTP id a640c23a62f3a-aab779c1559mr85659266b.7.1734088382563;
        Fri, 13 Dec 2024 03:13:02 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e6c67sm1224446366b.187.2024.12.13.03.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 03:13:02 -0800 (PST)
Message-ID: <17435684-a1f5-44cd-ac25-7e8efe88c754@linaro.org>
Date: Fri, 13 Dec 2024 12:13:00 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Revise Meta (Facebook) Minerva BMC
To: Yang Chen <yangchen.openbmc@gmail.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, patrick@stwcx.xyz, amithash@meta.com
Cc: Jerry.Lin@quantatw.com, yang.chen@quantatw.com
References: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/2024 14:32, Yang Chen wrote:
> Revise the linux device tree entry related to Meta (Facebook) Minerva
> specific devices connected to BMC (AST2600) SoC.
> 
> Base on:
> https://lore.kernel.org/all/172722509817.374662.7338401100529556748.b4-ty@codeconstruct.com.au/
> 

I don't believe. You are working on some old kernel. There is no way you
can get my address like this. It's impossible.

Form letter:

You CC-ed an address, which suggests you do not work on mainline kernel
or you do not use get_maintainers.pl/b4/patman. Please rebase and always
work on mainline or start using mentioned tools, so correct addresses
will be used.


Best regards,
Krzysztof

