Return-Path: <linux-aspeed+bounces-3299-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43567CF45D4
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 Jan 2026 00:01:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqqCt5z7Kz2yFk;
	Tue, 13 Jan 2026 11:01:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768262490;
	cv=none; b=LOPc2lVuTT/ldaiBWNcXKsmC/ePZ6O++wGd7Tnr4J/u5wT1RWeHJcytoVN9MAe1RNgvD0k3CAsDexJcCaQKsJyzg/WQlJA1yR4wOgoDeRJ92X1VP72skGsIJAXDBCzjHFv+CTesuskp8YRHj4qg/Vu+GRXiaW9tPfvAH1yIi0vYKW6gpMTrbpkqfd2Cy8zIaea2RoBymDAc3gq5kfdMBZB60chYvkM2LooOM19wZl0K/fkA0y7Ryccpe6Rz+nVdoNXlWkcfqKMmbCFqf4367YbYCnVl/lgZ5jNWxSExy3W0mSzX+STNLABoLC20yEalfIbZQ1AGm7wire9AaKtK9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768262490; c=relaxed/relaxed;
	bh=/Ca7ba810N8yfT2a0uOQiRTeHQwK7t+A9fpbfT6p0g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwa6T8R8Vv6eHAlGvCMKqJAJrB1OylfTbhwFqKHZ4srT2WkPJvwYxcjI0zwozermwnBUm/cSouHrtb3bAQzfEmb7dXiXrs1T8kB8yjMwcp+KR+uk4a9YoEE99wyjlCbPBXIXPoMQ9QNWrIkEYFr+parY28yzTjT02Y0tykTafarjD+FPd4yjFhA+WpyrS5tVsjhEh/jJIi8af8WgWYdhFo+RMMG5jliKSAonYKHMyKLyCIPvw4sek49wrHp5LQWqg4LfLSmfinE96UUBJiBJZrhG9tIn/syjHD4MwjniQHsxAY2ImwT74T+XwU8EB3VPuQefq/8FyvdljFlX/DugNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aD+eyfZd; dkim-atps=neutral; spf=pass (client-ip=74.125.82.176; helo=mail-dy1-f176.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aD+eyfZd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.176; helo=mail-dy1-f176.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqqCs4yCDz2yDk
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Jan 2026 11:01:29 +1100 (AEDT)
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ae53df0be7so11309344eec.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 16:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768262428; x=1768867228; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Ca7ba810N8yfT2a0uOQiRTeHQwK7t+A9fpbfT6p0g0=;
        b=aD+eyfZdg3xopHmzEQ7XHkqFT2Wx/m9DRC+WrrKd+nxwjC63qyl7ivj8q3YMKro0/E
         SBRCgf6SlZIicfphY+CXKECNngEm0SCMe5l9dU6qDxCNQuROjpjj4mZ+OuSGN2BmnC/F
         34ml7fT/StsezOF4fuA2QCi5uDDBiD9/uTyze/+vV8ITR9o5f2Inbr7WWTEhSh5F5gpx
         Flh4OL/sT7PKgltKUvyCxkWAG5RlblQIp+u0OLsy+0Npa0Wna6ZWb618yBbW22Ktm1Ss
         bbiAzAxTPxeeR5efT64iNOoV6xOBqft2QEnoibWmssbeIknP8mWO9ZgdnV7pSumRVKza
         litA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768262428; x=1768867228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Ca7ba810N8yfT2a0uOQiRTeHQwK7t+A9fpbfT6p0g0=;
        b=HTggwJFN2iSZjNJ5oTrHAX6s2p9rkNpMuWI5V/+OI2TaVq0xuQ7fVp76Bm+j5fE5UE
         JyByz+MFrNSiLd368BwCGcQauGzGOQXOvBv+q4D6cb9D6oAFeow3iZ01a7PeHmqIEGQz
         YwJWBIh00NSGfdOW5eMWCDxX6kWQ60/W281TK58SNbWyAIxPbh0xYox3zg1Xjc9WTu6e
         85asIzI1KhPlaItfsg4d5yuTeBErVD5qbleg1yds5arEXJpN/VgNdaumoo8QHEu/zWHX
         Kq9x2bOtC6XAZBjANh9rUY5hHfgznEbYyEk0uxcsgJsXACwynFigqSRcNQBrglLqq5tw
         iJTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/eNjfiXAjkX3JDWlUmyo76Cip9YyRLKaPwbjv3S0xDrqFfwhRyPBePTSj8uv0Ir4P0nITMca2YTWdhtA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzkC/0I1yvMRJ4oMlZKn7IH8CugjzO7fV1fd1QmCB5wYLrrt8Wb
	HHQf30FkyryumdhKVP3cbTF84uL6ijOCOqwptISHsri+fE8VtOgjD9ju
X-Gm-Gg: AY/fxX7yRYxqjPUZ2wnOu3xfykMcLLjl7YkLrhHos1W+TqJugvPmnRGEO3OPuptTvFc
	XtKAWqRFRen/BH+mcyE0aiGimyuC9FAbmoO/N2jD2TwTNWjsZOzRt07BH5iKVidKePwCBE4oYG8
	HV4SXDHrsQus/GVT9W6ZtTNUZgHpnMlSYe9Xz+C9FfrEwn7F4CRzPthGnzGw/lpL5oVSDfJUSao
	nbbfjoMYW+qU4+7V7o/EsoyA++NNbGzBT75Ws1t8KoWX5Yb8/FcxUS6aIhURaxwflPweaGyV8ts
	U6Q+ADSr7vvcwW+mPtFGxCxicOhnRuRJ7iMgpdYaKCehX6dy6j9TJ4gT9HUu92H1hkIE0CSr/6l
	JbqrLg+eq/ixE7ewwPpZctWV9qlVI6kk7UUhLzZq7KwzAf4K4la7MICW826q2fmGE4ctPv6nQmY
	27Y7VDkgMV9ACyC1LWRVjJaYOf
X-Google-Smtp-Source: AGHT+IE6yvQ2ddlvX9nyemFmo4N5T/S3GXfv8OCsJYg1pE6WW3PJHwa8O1dQ8ly5F9NmxtGXBloc6A==
X-Received: by 2002:a05:7301:fd8b:b0:2ae:5b24:1cf6 with SMTP id 5a478bee46e88-2b17d30f886mr14686787eec.32.1768262427467;
        Mon, 12 Jan 2026 16:00:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078ccf4sm16958219eec.16.2026.01.12.16.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 16:00:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 12 Jan 2026 16:00:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: Convert aspeed,ast2400-pwm-tacho to
 DT schema
Message-ID: <8d63c13e-15d2-4555-a110-4d446f3db314@roeck-us.net>
References: <20260109-dev-dt-warnings-hwmon-v1-1-f2a84cdb0e1b@codeconstruct.com.au>
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
In-Reply-To: <20260109-dev-dt-warnings-hwmon-v1-1-f2a84cdb0e1b@codeconstruct.com.au>

On Fri, Jan 09, 2026 at 04:40:28PM +1030, Andrew Jeffery wrote:
> From: "Rob Herring (Arm)" <robh@kernel.org>
> 
> Convert the ASpeed fan controller binding to DT schema format.
> 
> The '#size-cells' value is 0 rather 1.
> 
> Some users define more that 8 fan nodes where 2 fans share a PWM. The
> driver seems to let the 2nd fan just overwrite the 1st one. That also
> creates some addressing errors in the DT (duplicate addresses and wrong
> unit-addresses).
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
> Hello,
> 
> This change has been on a bit of a journey[1][2] and was eventually
> integrated into my RFC series tidying up the AST2600 EVB at [3]. Rob
> did some further digging at [4] and I've now addressed his finding
> there.
> 
> Much of the series at [3] was merged so I'm splitting out what remains
> and peeling off the RFC label after making necessary fixes.
> 
> Guenter - I've included your A-b tag from [3], but as I'm sending this
> to be applied through the hwmon tree, do with that as you please.
> 
> Changes since the series at [3]:
> - Update #cooling-cells to 2 based on Rob's observation at [4]
> 

Applied.

Thanks,
Guenter

