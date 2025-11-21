Return-Path: <linux-aspeed+bounces-2976-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C83DCFC500
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Nov 2025 19:20:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dClS11rmTz302l;
	Sat, 22 Nov 2025 06:20:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763752849;
	cv=none; b=g7Z68tykTkwD+S2AVAGgjW7F2vLvDl6A+Bx6yVH00g/Qp7QLA/nAf7jmSsQlPEa3L3VS+MJmTeKxYj52Pckyy0acj1N7SZf2bFkJx4tLovUvcupSXq0PRvNqF/Gwv0+n557vDTHpoHxSdxqHMlxizCW6cxbepfLb+zUSC7VSYcnrOgY+HDHpYwH2J97pWAI8NMcIkyX+id+X7GDy7MFQmVEen4ZiKnclZXtHFW5MkQwrHpSBlC1tKsEjiWQBRquQyQlSa5bx60UuSvIk7QgAx4bZbLJ///yWVp9+PfTzaQKVQHA1ZidfRMlao9eg1C4qoDXH4qJ8ocrRgg12PoyjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763752849; c=relaxed/relaxed;
	bh=DkiySot0JlTeM81NDSJaYwCGtmRwSko9cXTn9FLOklU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpahy/KM4FBNTplygNMSnOaI77l5G74BMjrOOjagMy+xGNuxB7EsjFSOQzp1lIpScW281TO60ZeizbXZCjOajLdFesECmosXiE83hG2zJO6FraK8Ufw9uhkLDNZWzp/uwTjb7P+wJT9/OeQrkhU131w2rswZUTlM9M2LNomYhkIdOC8DMjjXr6mK11OZIyFKjngSvV4C9VSVZui/BHRkC0rlWWbnOzWEQY0I4EnUWDXOpI+39FAhk4LTKwPgFxwAA8ZZpn1bwoiTa+GEIa9KiwNChhcwfIDpG5h0jVs/wlCO2e56PuFJ/WTjAjxHmsSl651VCBCQx/3zVmAWnOfU/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Pgnyb/ih; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Pgnyb/ih;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dClRy6xrBz2ySb
	for <linux-aspeed@lists.ozlabs.org>; Sat, 22 Nov 2025 06:20:45 +1100 (AEDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-7b9387df58cso3754727b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Nov 2025 11:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763752843; x=1764357643; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkiySot0JlTeM81NDSJaYwCGtmRwSko9cXTn9FLOklU=;
        b=Pgnyb/ih+V04a5l8eCXv4Gkm7orPSJZxHRitD7M0uEuvehvj0FnogMfVnxfEI6Nr2o
         cJHzj1wBN4aOHp7nAyCu77p8+V2ewtcAS+vLdwMUyVrRS2NKOCifJRLH04HWxbZ0nvCV
         Ls3DvtbKntKGzF5RxIKbyx6wEQuQZgyAAvpvQePKhl8glMUDXARIWbsFz6das18wLAja
         7OVZqWXAYOH53dy7kGqN9EjU+mUVTi+FhNNf6p93NNxtEHYIOfooBdCTwLhNZXXbqbLy
         pmS2cTZOQt4VSbqRCJONG1uTY4w8VXfW4lIk+Bo2sonF0/bE7hUDQx3r4/+7yK3Wekux
         6rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763752843; x=1764357643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DkiySot0JlTeM81NDSJaYwCGtmRwSko9cXTn9FLOklU=;
        b=GUnxUuFXXIThdDAbnQJ5lnzzo+ah81wHUOIOcjAZO1cvjrePv3pShxiQvI1OQu/ftA
         JWptkm/VykyhrdbWLJge57Qm41zcLdP6SDvmRy0YgAEyrk5FDGn9UjAKTht0AVrlEkSU
         WvLtORC1LHXgWWAOSaiyvwIynuou26Bf7DeP8dRfplwFIy7MnVrNc9QSlOnMORlrZC2V
         V0eZlWe6OGl6NxAlggeZPXlk1Zh1dwnlNM8VP40+Exrz1FZq9x31D3+BEcEZF+00sMc/
         Z5Uv7s2ln8dj0IjdgzD/U/mbHaQvUg4wfywp+QbCK7Qv5OvveP/MQarsIg1Rs0bOa1Mk
         otbA==
X-Forwarded-Encrypted: i=1; AJvYcCWGyRKSekkLdHh/P4LSspmbCPSjaeBTJ3AFGcziTVzl82mTKtRWf9MAXjJkBlRJe2jBQanOxmIlqMwfEW8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzqObtXHABCWmNBUmjo4rb9CniCoQJ3w6WURAUCchTbSySUZ+gv
	OGmkUK4cVNkLwSnOzYVaX3k1h0CKJGqs1x4xU5vWNxu6O7eL1mdt2rJq
X-Gm-Gg: ASbGncvJM5E8qCCwdRbHhjbqsNeI9LvX5pKPtjmzXHOuvWl42UvlTNiuyf26OFw3Azq
	ngktTO7uEiVg91z9SVmVW6a7YqMTfZJvMT+ir6VnossdNc4rUzmEoKsSac2fjjSvS4zbdfoWmcj
	tiW6jaZrQLmGQc4PAk4gSdVUnKlRdzyzcOO8Z4oX4TMjYt6kJdahFtdDyip6TPydwz+SXBaJyAM
	j1OgS56IvJ/gD0nolUK+MBilzZhUo20vLzrRlp879wWKEyDdBo24x3HuZxoxkRTMI2pcq29v1Yk
	FDff0s+Fg4BqRkKbYtHSKEqYL7P/XNaA6uouxSyMLmPQS+Mj6H8xjLgxQ04zRwbUC/2u3rEtzCy
	dipqUw1NukXcoBVSbcyndGi5mvdtyfs9yVDntB3dVJEmds7ReXL8sDFVrOMuQZrEuRWiTOM2FWH
	Oxsr4QRSV6zTl5LKacaUaLjpw=
X-Google-Smtp-Source: AGHT+IFGSMhAaX0qmWupzfxH6SdMnBmmVUzXc6aFgY6Jd8H4M51kLSvwGWZdzl8zwzxLzIH4iUB1jQ==
X-Received: by 2002:a05:7022:793:b0:119:e56b:c746 with SMTP id a92af1059eb24-11c9d711aa6mr1429994c88.11.1763752842786;
        Fri, 21 Nov 2025 11:20:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93de6d5csm18602216c88.4.2025.11.21.11.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 11:20:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 21 Nov 2025 11:20:41 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add AST2700 compatible
Message-ID: <d47e02aa-5cb3-4ae9-b2c8-896534f27404@roeck-us.net>
References: <20251120-upstream_pwm_tach-v3-0-eaa2f9b300a2@aspeedtech.com>
 <20251120-upstream_pwm_tach-v3-1-eaa2f9b300a2@aspeedtech.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-upstream_pwm_tach-v3-1-eaa2f9b300a2@aspeedtech.com>

On Thu, Nov 20, 2025 at 07:12:31PM +0800, Billy Tsai wrote:
> Adds support for the AST2700 PWM/Tach controller by extending the
> compatible string enumeration in the device tree binding.
> 
> The AST2700 PWM/Tach hardware is compatible with the existing binding
> schema and requires no additional properties or modifications beyond
> the new compatible string.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied.

Thanks,
Guenter

