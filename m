Return-Path: <linux-aspeed+bounces-3932-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9283CF557F2
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Apr 2026 09:45:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzgb11jL7z2yqT;
	Mon, 20 Apr 2026 19:45:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776676568;
	cv=none; b=EBT5eS4YRI3gAmQyPRRbfJkrrmlf35WflhHvoltdUkrMZdY9y5p/yVHHobeJjX7hwZEjxlvTAS4r+LxX6h8DVQ3rXtNtsLut9vIIQZiahDkMhq67bzgk8Ihaqh1XYkRCnaFB5gQTNliZNmhmBU99hOXEahcqUXJbitu05P2X7k3yU73rqo5oX+3oLVZC223BwmJzCGd9aANBfIPLxmEOxUFJgIYaLNyq6+s7VrRJXWOMF8PAJyyEF+RlExwp0jFg31Ik4PIuksmgtQIl3hQy+N0dJn1q39tchdBy8LAo9g58VSPBCPZb9t7xEVGbGsEVGJ3OtF5hc3AsHsF2QJxV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776676568; c=relaxed/relaxed;
	bh=0VacLWHx6mffMprulvbIkPw32rMmqdQ4bA7Snxbp9Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKFIUsraCgdribaf5mKYkeHM7Us8yddZLVvTirfaGJMmnqFik3u0xXGHyKixoF6OhWKMM4mUVr5iAGFsN1jTlrfjFL+ArdJCPNuxHHhsDsetRgN3J5VpafeoTL8S/pjm1/KJv06X1/+0Nqn5XCiemRljyKCndVwap7036WF0K2Q069Ohnf+JjWnYorJfOhdcK2/254cm6NY/wvT8WccT4Yelk/vI9BqWmfQoqyhKyce9fSwJwTCu7etGviiqOvSiJeAmlqJ7X0qSWDYF7uAc4vlsOAzeF4qLy2PlnfugAJd+NdQJKsOIz80CRCLSdJ5McPK6pIP0ONc+GiUOoGL5rA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WkjoQzg2; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lg4hFjAp; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WkjoQzg2;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lg4hFjAp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzfx24SGzz2ynn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Apr 2026 19:16:03 +1000 (AEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K97rkJ1600322
	for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Apr 2026 09:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0VacLWHx6mffMprulvbIkPw32rMmqdQ4bA7Snxbp9Tk=; b=WkjoQzg2kqWzA18F
	L6HAtHTpaO2CnNqgdbGotdo7MjqU+UkURHw3HDNRTwADiluxEpeXii9D7xNeszLM
	IEs6FMzoc53jEmRJZb61ZGOrBTjjGblKsDbP+0GZSeuYmyp1cv9gGG+b2VmkwKIC
	Xt3VN202SI9nQeW6M3IN5HDGtPt5GphiS03suIm3kQ1pP2Mj8UDOGg3N1uiFHlM/
	emwo5miPIDLBj/8wBqZUZWwrXHyhocldi2ifrxF8MJddhIbEFhrVFHWcuoy09xi7
	n9YX7074jVz5JC2mrqHrDRkznWVoS/+UKzhd99GvOTdW8jE1MeqYeXSmt4XAzDVd
	vUMhpA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh898141-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Apr 2026 09:16:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d8e4c29caso64030341cf.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Apr 2026 02:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676560; x=1777281360; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VacLWHx6mffMprulvbIkPw32rMmqdQ4bA7Snxbp9Tk=;
        b=Lg4hFjApKiX3JdxlvVGUwsT5zh0eZj83b5DwF8X44NU6i9WaOl+56EPArdKmCbT8nr
         VxRjixngCxClv3NOZcNFykCFzfnyZQm4I9ZRtVXuIJsjbFgUoxR41lAnZqRF9jfGb4QN
         6tbs7Or6jeN8EOxNTALflfJaBvIjhmDav4mN72OuzzpAjFKfQGMpCFRhcBi7zHPrVIjb
         o2stYG9TZaNU7P0LXe6oIVYZppTzsxsFyLcBpWmYqSQA0n3vIhytSD9JOdCCwGguPoVx
         StdE/yfJ9Nbgr7nwvjM0XvBkBSBkOzCKl4hOt5fjDurHp1o6c0jxS2nWnxdCxVON4436
         +yXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676560; x=1777281360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0VacLWHx6mffMprulvbIkPw32rMmqdQ4bA7Snxbp9Tk=;
        b=M02MeQeNLg+TPqm3k1NNLQ9qC5Or8kmLaWy+xpMXRIgQbJ6JenfV0QZXSkkrHLTyaw
         HwdEQXFxsbGUUhIU9nimsK2K+swVUAmiMTGVMnTawzjZxIDaF/SD6v7F3YBTQbt3MmuY
         ggYLAPiDTkYvPl/aOO+GfrUfVCT75naeOayPkzZmtjSZ/g2ltQMg+8I7EzM/nJWVGXYS
         bo2++YKyaqmXVj+u3XYDkQTsrN5CI/5nrSHUQ+2sHDlCi+Jk/Iq/7mSRsmJpuM3bc7fH
         5M3iZ+yCUVqg/RdFcv1xbmgZuDlfLHFD+DMoE38Bpb0yT0Ojb/kkJmjm3ixQ4FwPlnWh
         YH8A==
X-Forwarded-Encrypted: i=1; AFNElJ8rAF+mGPZpJ7JDGx0fPrhyEYwhEHnlm/mSSeMwCViJebLFOeThvz0jjV8IXb1vztbqZOU42v/ElTTtCIE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyp1T9SQYvHhT1A8ue0+Vry5LYbwBXXilEZ/gdvPAO7SiUMRBAK
	bjWo84GzlQh45Vx4f37I+qBcrnf9cFgznHS/Vcj8a6mgBdVqAHR647gSfnyjyX0W668PM52mMZG
	OrVBVzWsHjKH5h6hrKlbUurS8wkagjabKIZcg3dOa/AsIH5hcgnI8RvLEdClw/IKSDBhZ
X-Gm-Gg: AeBDietRUwta3GkCQ508P7YaYqJsuFcC3GtI+P9p95m80JBt/C8WuYpxJ570W1m6s7C
	X8KLO1EN4+IjXosoCEROxyWiWgKHVDXcAplPJAk/4GSIB+INFcNR22GtYux7qGviIgyWHovUChf
	UmrZMxglLKYwEcoa5slIRnNQCbmQ2pnethUasKJKyyQnd650EvVsApNZUm+I2lDkNQDWyHXyN9t
	HH8j5wnpThdsj5UT/a61xjwaOKQloEHfB8gNlW1qwAG1Ym4/Llk+jcQv/gxs0B7VTSboKIk4h/U
	wOTcszPtf1ks4AXmTNcFyy85L/tI/Vj+yBTEh9m8UihJ5wi5rmtPoRDnEUr7VHw6MBCgG+WvODs
	s+X/A+6JF2JTMjMUW4SWZ1MADoawIt7jLd0wLwAJWkWJFHei/05CmYLQ3Ynk=
X-Received: by 2002:a05:622a:1305:b0:50d:8db0:7abb with SMTP id d75a77b69052e-50e36ecfca9mr193000831cf.42.1776676560339;
        Mon, 20 Apr 2026 02:16:00 -0700 (PDT)
X-Received: by 2002:a05:622a:1305:b0:50d:8db0:7abb with SMTP id d75a77b69052e-50e36ecfca9mr193000561cf.42.1776676559914;
        Mon, 20 Apr 2026 02:15:59 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:776:c20f:3f2a:49a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm27457471f8f.0.2026.04.20.02.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:15:59 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: aspeed: fix AST2700 debounce selector bit definitions
Date: Mon, 20 Apr 2026 11:15:57 +0200
Message-ID: <177667655421.14099.13456882135654197877.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415-gpio-fix-v1-1-b08a89b31e6f@aspeedtech.com>
References: <20260415-gpio-fix-v1-1-b08a89b31e6f@aspeedtech.com>
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4OSBTYWx0ZWRfX2csXuEthWpKs
 HanqIHt6+4IwM5lQDa5zXcjw0InGSr8tGzuRxFz6upOE0h5y/zkFmwLVvFnigsVqu63XPEn0ICa
 KX7g0Uqvgon/EetjPIXQwnKr2MhbM1yUn+qW3IVxgvTa+DP7l6nuPpDTQOi42nZXiaO5O89hvkp
 2tutKr2K634GK6krCL55iDZicAPKQsAnLciVgTd1HDubf3UvOcmfcVBQid8Ct4MSxhrEjUtHnG1
 E/uleFAQMcdxr9DHePBSCAv1zbwLyeBF8wdhxsUvh+VKR9l6QGzZEZ67IGkUel2GFSbu5XDjfMW
 HPV3jCqGDcjVAjjTcAnyunRLN5MFZFZIZkwhhlIr0dAXafPnWl+2XEz0cOJQd19m9M4Umvdwvk+
 Y8D3rt5paH2XcPyJZU3d7VYxzWPNn4+TahU0/OKOsvizsyTNVLj2DErEeeD51ReqakiGtxl129w
 72MEtjceq9w+IewHw1A==
X-Authority-Analysis: v=2.4 cv=D6B37PRj c=1 sm=1 tr=0 ts=69e5eed1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=aUlvD_2W9BlSwx0EIeAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: aBPnoYB4rtkTv_GoaTioq-K01hCyH2oH
X-Proofpoint-GUID: aBPnoYB4rtkTv_GoaTioq-K01hCyH2oH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200089


On Wed, 15 Apr 2026 18:24:42 +0800, Billy Tsai wrote:
> The AST2700 datasheet defines reg_debounce_sel1 as the low bit and
> reg_debounce_sel2 as the high bit. The current driver uses the AST2600
> mapping instead, where sel1 is the high bit and sel2 is the low bit.
> 
> As a result, the debounce selector bits are programmed in reverse on
> AST2700. Swap the G7 sel1/sel2 bit definitions so the driver matches the
> hardware definition.
> 
> [...]

Applied, thanks!

[1/1] gpio: aspeed: fix AST2700 debounce selector bit definitions
      https://git.kernel.org/brgl/c/e31eee4a961077d60ef2362507240c6743c1c2ae

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

