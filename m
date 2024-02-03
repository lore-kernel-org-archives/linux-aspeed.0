From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 3 Feb 2024 07:14:58 -0800
Subject: [PATCH v1 1/1] hwmon: (aspeed-pwm-tacho) mutex for tach reading
In-Reply-To: <121d888762a1232ef403cf35230ccf7b3887083a.1699007401.git.alexander.hansen@9elements.com>
References: <121d888762a1232ef403cf35230ccf7b3887083a.1699007401.git.alexander.hansen@9elements.com>
Message-ID: <a70d020a-6289-4087-81eb-a4d6ea339b92@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 03, 2023 at 11:30:55AM +0100, Alexander Hansen wrote:
> From: Loic Prylli <lprylli@netflix.com>
> 
> the ASPEED_PTCR_RESULT Register can only hold the result for a
> single fan input. Adding a mutex to protect the register until the
> reading is done.
> 
> Signed-off-by: Loic Prylli <lprylli@netflix.com>
> Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>

Somehow this patch got lost. Sorry for that. Applied.

Guenter
