Return-Path: <linux-aspeed+bounces-144-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BA2D6C285
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 Nov 2024 18:18:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XtCRd4mvsz2xpm;
	Wed, 20 Nov 2024 05:18:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732040317;
	cv=none; b=ZKinKY13HsMt37rBeNYmuZe8ZffyiH7dT5cd+DTKiSdCw7dWlFDqvF+sUgLq5IFFe+kkSH1DsuFb1fwn0Ob8V/LdEDHIt8UVSGBjTeVdq2O/UOq5/XojAsVcZpD/E2ALUUyNdyziYkr17LkxX3k+zMTik3CADwfVYao9Ub91bSa06bl3eR3IcJ/NmgKDKzRE7WwJ9g71StlyQRyy5C/Jj5/xmkLVj2v3d4//9noGoNWYQscJp2zKNdKgXKCvnIfGOy4MTyfHgzmLpGOf4WT1dROslh8JpD6chDFjQJKpLSAVsnetN91z4yU1XYMw/QXuXIN2By65AFim3MVL8xAOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732040317; c=relaxed/relaxed;
	bh=nhOz5ZgJsJXLep2/QaArx+bOSFWfYpjcDt7ubS08xow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQdWsvQ94hfkD8icS0GUK/5CVWBHMfIPLtXXkS5bTvfOIdwM4C9uw4aO6692NFeeJmamrMBQJ7mrVmHwykVEEGTEjbQ3jQtbnMW44mKvlN7L9x/E3XrQOaeaiZCEoserJ+mlTf9XYHPnyHpxoTrvirPafNwD3yOmwKWM8JuY1wC/1bFb+bGJcDW+XTCuWm/wRGksg0qvBixUsFjhhypsKK8zHQZ6YboEF7hNjFdOp8oa07Dh5p34aCJ1Hyrze9nHZ+WqlPvxzKQum4tu/iR3XRyazEqYQ+zfkkZdQL1QVYHX51oqq3I+kyVK7FmbSggZQ04orAxTMr8lKxU4oUy9cQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZwmhcXO/; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZwmhcXO/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XtCRc5cJZz2xnK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 05:18:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1D17CA42DD0;
	Tue, 19 Nov 2024 18:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E83EC4CECF;
	Tue, 19 Nov 2024 18:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732040313;
	bh=Wo4rlPhE92EUOyHR0Tl4T39RGOZr5gNuIEk4zdKuEZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZwmhcXO/6k1UcIam0xMjM1Bj2G4s8Y6JCdeSx+YAWiqCkcXJrcEc5cSgLkNR6gkI7
	 eeL//YJ4Is8fMMrnmo9FjX4Ok/juwuu6/WTdREYITGLr4P3DZNHrtjKZlh8jucI7nS
	 jxDwm7oTzxVUBrEKYbxH6zAGr/JxLAq2XR4Tae0tdpZ5hYQpkUNRKgNprRa8HJmngY
	 13LDCxnEadBe7ID+0QWW32zivGv2fo5XJwVuUr7d5CcXS1OgOzvx6zUjjepz/1ebVI
	 pLh5gdB2rDfbpAxOVDIgghZLrgHWzT/mrsDObonlwGmi9EhbPDRo4DAUDBAyR1SOzi
	 0BxaSD++w77WQ==
Date: Tue, 19 Nov 2024 12:18:31 -0600
From: Rob Herring <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	hkallweit1@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next 1/3] dt-bindings: net: add support for AST2700
Message-ID: <20241119181831.GA1962443-robh@kernel.org>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
 <20241118104735.3741749-2-jacky_chou@aspeedtech.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118104735.3741749-2-jacky_chou@aspeedtech.com>

On Mon, Nov 18, 2024 at 06:47:33PM +0800, Jacky Chou wrote:
> The AST2700 is the 7th generation SoC from Aspeed.
> Add compatible support for AST2700 in yaml.

"Add compatible..." is obvious from the diff. Add something about why 
the diff is how it is. For example, it is not compatible with AST2600 
because...

> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../devicetree/bindings/net/aspeed,ast2600-mdio.yaml          | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> index d6ef468495c5..6dadca099875 100644
> --- a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> @@ -19,7 +19,9 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: aspeed,ast2600-mdio
> +    enum:
> +      - aspeed,ast2600-mdio
> +      - aspeed,ast2700-mdio
>  
>    reg:
>      maxItems: 1
> -- 
> 2.25.1
> 

