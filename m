Return-Path: <linux-aspeed+bounces-2386-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A142CAC5B8
	for <linux-aspeed@archiver.kernel.org>; Thu,  2 Oct 2025 21:38:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cd4sx6cf5z3cjQ;
	Fri,  3 Oct 2025 07:38:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759441109;
	cv=none; b=gr3iKo559EV+L2+geD/jfbtBtzZb9dnhyuqCWPD7IO8ckWxsdCdbaQ7GnnfpX+0l0am9Z/jUy83GppWDkn6FoaRccun2DBK6Z/j3TY8PXSt70Dxjofi3BjT5vx6xhPbLFC6D6M9cJDO6xKTfia5U5+cs/FRccRptZ8YTtzAhtUiEBqHpG0TCfXvo9ynnSXbijCDvAC8RpmSyRRzJfDaK7mo544TMtM3kfMg+WvcDmicrMVSoc0IykZMZ53wiN75lWDMJvEFLeBcYpHQuspw0n8OYu1JirqFyoUu4DDN134CGOGSwg/DINRVS1akZymAkyTAyD91f1Dw/gu7DOni1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759441109; c=relaxed/relaxed;
	bh=DIgw2TUDYPujfob1ItVYazOFg+arl5pUESpq99Cor8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9EFs2eU8867bjp5rbeIYBmwPDKzHM4AaUb7wg0sINTlNLbZZrx92PEYLoVzPNR9QG74PJOBvdeOr1HBw4LlOMW0L8Rf6IUPJ/IiWetUKRFFvix1tipTjQv7uP3/06RzrNY3gLmNQG7pv/vyAXbJkOiTlH1E7n+xk4/oSuKak23IeeRsL2pMj0GEC59SQnZdQ+rz3FuH3WVKyEzHc6k5uMBSBZ2C1eLo/99zRvk8DvkTQZY84dwNNddIMV8ZAE9ZumL8OvOaceaoDeFtxDjhe+RMK8oHGRenQgXZqKPmyfMC2i+D0alfIR3LbtSkQG6ZMFrj1q/kwfcMkTLwuE6JQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=K8jSk6We; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=K8jSk6We;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cd4sx25DJz3chb
	for <linux-aspeed@lists.ozlabs.org>; Fri,  3 Oct 2025 07:38:29 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-7833765433cso2139654b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 02 Oct 2025 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759441107; x=1760045907; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIgw2TUDYPujfob1ItVYazOFg+arl5pUESpq99Cor8Y=;
        b=K8jSk6WeAlbmPkpfJTD/N/DrkiFpjqLeAhfolY9spBIOi+f3fw0Nj10NQhD/cPgh4e
         VpyIjKUzpmG1gxF6ED78d36MVgVNaNzpm9JKacQs2xcTWwZTMZ81qLh5WHj0EeCwyP9h
         kDcVzkqvpbK554CyIuPzsWnVBandJTCTwYMdmeqS6ZcZhOWD7vgTe1RMUS50g4cU24ON
         PO8liH778YRGv8rykRa04nbvSS6X5iSgoCYF9GJeR8BunILyG48Egjeymron1VdPWQPQ
         0frAjU5oigJ4RTnnqY/293a0W5ymnDZQCovVAi5MjSMFijuksFzqOuIu4KbVFH8jJTaL
         5+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759441107; x=1760045907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIgw2TUDYPujfob1ItVYazOFg+arl5pUESpq99Cor8Y=;
        b=KRDtthNOuSjuMc9yaQH7C/4+zDfJ4SsrO6qXDwKaKmdAL1ea18v0mYYpa17dcEKtvn
         ZbRU1aDv6I3G9PEonuEl4BmQ10nSMNDDxqsJke1SUZdyIh1A7XVk9zgiSOsTNXPplx79
         eiqz1zsRMlLUhtNsW6lA+yLwiJzJLG5WjZIwaO0bOxtA+WQLv9vXTMhNNgbe8NacU7pl
         qeYVe0Ph4XjZ3ioQtgec9e9sFPO381VkgRFTquadsU9hXT6roiPbeOxfeNG9VlvLFGzd
         0ihTVPPxo87AqiIH8gNRl4+DSp5139WKRmWHcfBiW/VvGvnJHQCZ/eVBQU0MiAW1jRft
         TqxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpc6D6YU8yAntwBl3GLtq2b4P+Eibrp9SYQIXwQh5qX7yDH5/fpq5XxhrMx3cLcAQIBEtm5pb4iB+HRIk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxZe6OmC2j7BKmd8gk00jqPqn7DzppVTJbQ9NjQukZdq56+wofx
	+MX2XBB8TotbgNABmRevHhiP3iOI7dZXbUyLXWfyqHH+v30dIjB+7bUY
X-Gm-Gg: ASbGnctJ4lerIaMu9Yys4C9n7++uvcxhKBSRiilFH7tX/Per41VneFzs4XKrour/4pM
	aMWSL9TXt7eMVWskuBhLpbe0xMA1yXwjn0lk6Guy1SxblGPUvFGqKcebqfQQXTYYl12vhSUzeRL
	UBJGtzLHJnLBjxXTEwI3iwy8TlJaW9qw2to+ZTaFIQ2hOzrQ3izxpu5V/nRXapeoS/6o0y0mqak
	4syF1lAMYRYDAXrLx3pgJxTDhNnZSJSj+32oQgBJaBvsYT2hwMgoZncuTqo3es9bRsUQMzm35KW
	fiNXLvqRHKjvFL0pw17k+MeIw9iHW7zPM+6F39EW8xd/F9FE15b04Eam/bTiAJ2wZUnZuClwQaB
	fdpz17UJU+9yGrbadJKlXxanmkRALWPWaRHJVDviI4VnVBTLW6krMYFcPD68=
X-Google-Smtp-Source: AGHT+IHKI+feEMtSNCRgXeWWSvyIHg/eMcVz9KANAAoF8cg8/wBIuazCOx9v2nwjg3cKvHoW9MEgFg==
X-Received: by 2002:a05:6a20:12c9:b0:263:1c48:912f with SMTP id adf61e73a8af0-32b61dfb34emr1222197637.12.1759441107306;
        Thu, 02 Oct 2025 14:38:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02074549sm3020231b3a.76.2025.10.02.14.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:38:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Oct 2025 14:38:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
	chanh@os.amperecomputing.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v7 RESEND 5/7] dt-bindings: hwmon: max31790: Use
 addressed fan nodes
Message-ID: <c7c23305-d53a-40e1-a783-9ea8598c96d0@roeck-us.net>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
 <20251001144441.310950-6-eajames@linux.ibm.com>
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
In-Reply-To: <20251001144441.310950-6-eajames@linux.ibm.com>

On Wed, Oct 01, 2025 at 09:44:39AM -0500, Eddie James wrote:
> Since fan properties can include reg, the fan controller should be
> able to specify address-cells and size-cells properties and use
> an addressed fan child node.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter

